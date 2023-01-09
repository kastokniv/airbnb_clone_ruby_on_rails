import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
    copyLink() {
        navigator.clipboard.writeText(this.element.dataset.shareUrl);
    }

    shareWhatsapp() {
        navigator.share({title: 'Whatsapp', url: 'https://www.whatsapp.com'})
    }
    

    shareFacebook() {
        navigator.share({title: 'Facebook', url: 'https://facebook.com'})
    }

    shareTwitter() {
        navigator.share({title: 'Twitter', url: 'https://twitter.com'})
    }
}