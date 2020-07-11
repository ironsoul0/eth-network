const _deploy_contracts = require('../migrations/2_deploy_contracts');
const { assert } = require('chai');

const SocialNetwork = artifacts.require("SocialNetwork");

require('chai').use(require('chai-as-promised')).should()

contract('SocialNetwork', (accounts) => {
  let socialNetwork 

  before(async () => {
    socialNetwork = await SocialNetwork.deployed()
  })

  describe('deployment', () => {
    it('deploys successfully', async () => {
      const address = socialNetwork.address
      assert.notEqual(address, 0x0)
      assert.notEqual(address, '')
      assert.notEqual(address, null)
      assert.notEqual(address, undefined)
    })

    it('has a name', async () => {
      const name = await socialNetwork.name()
      assert.equal(name, 'Social network')
    })
  })
})