const puppeteer = require('puppeteer')
const request = require('request')

function Scraper(app) {

  this.app = app

  this.sendRequest = (completionHandler) => {
    (async () => {
      const browser = await puppeteer.launch();
      const page = await browser.newPage();

      try {
	await page.goto('https://wellsfargo.com', {
	  waitUntil: 'networkidle'
	})

	await page.focus('input[name="j_username"]')
	await page.keyboard.type(process.env.WFUSERNAME, {delay: 100})
	await page.focus('input[name="j_password"]')
	await page.keyboard.type(process.env.WFPSWD, {delay: 100})
	await page.click('#btnSignon')

	await page.waitForNavigation({
	  waitUntil: 'load'
	})

      } catch (err) {
	completionHandler('Error: ' + err)
      }

      await browser.close();
    })();

  }

}

module.exports = Scraper
