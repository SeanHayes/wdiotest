import { expect, browser, $ } from '@wdio/globals'

describe('My Login application', () => {
    it('should login with valid credentials', async () => {
        await browser.url(`https://the-internet.herokuapp.com/login`)
        console.log('got url')
        const puppeteerBrowser = await browser.getPuppeteer()
        console.log('got puppeteerBrowser')

        await $('#username').setValue('tomsmith')
        await $('#password').setValue('SuperSecretPassword!')
        await $('button[type="submit"]').click()

        await expect($('#flash')).toBeExisting()
        await expect($('#flash')).toHaveText(
            expect.stringContaining('You logged into a secure area!'))
    })
})

