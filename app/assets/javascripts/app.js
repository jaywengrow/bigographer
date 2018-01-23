/* global Vue */
document.addEventListener("DOMContentLoaded", function(event) { 
  Vue.component('line-chart', {
    extends: VueChartJs.Line,
    mixins: [VueChartJs.mixins.reactiveProp],
    props: ['chartData', 'options'],
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
      favoriteColors: ['#F0F02B','#29559F', '#F54600'],
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
                return {
                  label: 'Number of steps',
                  borderColor: '#f87979',
                  backgroundColor: '#f87979',
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