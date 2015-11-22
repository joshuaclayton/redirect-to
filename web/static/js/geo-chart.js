class GeoChart {
  constructor($element, google) {
    this.$element = $element;
    this.google = google;
  }

  run() {
    const data = this.google.visualization.arrayToDataTable(
      [this._header()].concat(this._body())
    );

    const chart = new this.google.visualization.GeoChart(this.$element.find("[data-role='output']")[0]);
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
      backgroundColor: { fill: "transparent" }
    };
  }
}

export default GeoChart;
