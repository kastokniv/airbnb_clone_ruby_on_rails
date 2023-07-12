# frozen_string_literal: true

class Property < ApplicationRecord
  include Countriable

  CLEANING_FEE = 3_000
  CLEANING_FEE_MONEY = Money.new(CLEANING_FEE)
  SERVICE_FEE_PERCENTAGE = 0.08

  validates :name, presence: true
  validates :headline, presence: true
  validates :description, presence: true
  validates :address_1, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :country_code, presence: true

  monetize :price_cents, allow_nil: true

  geocoded_by :address
  after_validation :geocode, if: -> { latitude.blank? && longitude.blank? }

  belongs_to :user

  has_many_attached :images, dependent: :destroy

  has_many :reviews, as: :reviewable
  has_many :favourites, dependent: :destroy
  has_many :favourited_users, through: :favourites, source: :user
  has_many :reservations, dependent: :destroy
  has_many :payments, through: :reservations
  has_many :reserved_users, through: :reservations, source: :user

  scope :city, ->(city) { where("lower(city) like ?", "%#{city.downcase}%") }
  scope :country_code, ->(country_code) { where("lower(country_code) like ?", "%#{country_code.downcase}%") }
  scope :between_dates, lambda { |checkin, checkout|
    joins(:reservations)
      .where.not("reservations.checkin_date < ?", Date.strptime(checkin, Date::DATE_FORMATS[:us_short_date]))
      .where.not("reservations.checkout_date > ?", Date.strptime(checkout, Date::DATE_FORMATS[:us_short_date]))
  }

  def address
    [state, country_name].compact.join(', ')
  end

  def default_image
    images.first
  end

  def favourited_by?(user)
    return if user.nil?

    favourited_users.include?(user)
  end

  def available_dates
    date_format = "%b %e"
    next_reservation = reservations.future_reservations.order(checkout_date: :desc).first
    return Date.tomorrow.strftime(date_format)..Date.today.end_of_year.strftime(date_format) if next_reservation.nil?

    next_reservation.checkout_date.strftime(date_format)..Date.today.end_of_year.strftime(date_format)
  end
end
