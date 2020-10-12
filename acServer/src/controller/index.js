const Base = require('./base.js');

// 显示页面
module.exports = class extends Base {
  async indexAction() {
    // let userlist = await this.model().table('user').select()
    // console.log(userlist)
    return this.display();
  }
};
