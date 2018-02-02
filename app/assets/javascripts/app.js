/* global Vue */
document.addEventListener("DOMContentLoaded", function(event) { 
  Vue.component('line-chart', {
    extends: VueChartJs.Line,
    mixins: [VueChartJs.mixins.reactiveProp],
    props: ['chartData', 'options', 'favoriteColors'],
    mounted () {
      this.renderChart(this.chartData, this.options)
    }
    
  })

  var app = new Vue({
    el: '#app',
    data: {
      options: {responsive: true, maintainAspectRatio: false},
      message: 'Submit Ruby Code Below',
      codesArray: [''],
      results: [],
      favoriteColors: ['#3f4144','#42d182'],
      chartData: {
        
      }
    },
    mounted: function() {

    },
    methods: {
      analyzeCode: function() {
        Rails.ajax({
          url: "/api/v1/code",
          type: "POST",
          data: `code=${this.codesArray}`,
          success: function(data) {
            this.results = data.results;
            this.chartData = {
              labels: data.results.map(point => point.x),
              datasets: data.results.map((result) => {
                var color = this.favoriteColors.pop();
                return {
                  label: 'Number of steps',
                  borderColor: color,
                  backgroundColor: color,
                  data: result,
                  fill: false,
                  lineTension: 1,
                  cubicInterpolationMode: 'monotone'
                }
              })
            };
          }.bind(this)
        });
      },
      addTextArea: function() {
        if (this.codesArray.length < 2) {
          this.codesArray.push('');
        }
      }
    },
    computed: {

    }
  });
});