import moment from "moment";

export default {
  mounted() {
    console.log(this.el);
    console.log(this.el.dataSet);
    this.el.innerHTML = moment(this.el.dataset.date).format(
      this.el.dataset.format
    );
  },
};
