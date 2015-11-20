class PieChart {
  constructor($element, google) {
    this.$element = $element;
    this.google = google;
  }

  run() {
    const data = this.google.visualization.arrayToDataTable(
      [this._header()].concat(this._body())
    );

    const chart = new this.google.visualization.PieChart(this.$element.find("[data-role='output']")[0]);
    chart.draw(data, this._options());
  }

  _header() {
    return this.$element.find("thead th").map((_, element) => $(element).text()).get();
  }

  _body() {
    return this.$element.find("tbody tr").map((_, element) => {
      const name = $(element).find("td[data-role='name']").text(),
          count = parseInt($(element).find("td[data-role='count']").text());
      return [[name, count]];
    }).get();
  }

  _options() {
    return {
      pieHole: 0.6,
      pieSliceText: "none",
      backgroundColor: { fill: "transparent" },
      slices: {
        0: { color: '#9D7EB0' },
        1: { color: '#757E99' },
        2: { color: '#7EB0AD' },
        3: { color: '#77A67A' },
        4: { color: '#EA2E49' },
      }
    };
  }
}

export default PieChart;
