/* global Vue */
document.addEventListener("DOMContentLoaded", function(event) { 
  var app = new Vue({
    el: '#app',
    data: {
      message: 'Hello Vue!',
      code: '',
      result: ''
    },
    mounted: function() {

    },
    methods: {
      analyzeCode: function() {
        Rails.ajax({
          url: "/api/v1/code",
          type: "POST",
          data: `code=${this.code}`,
          success: function(data) {
            this.result = data["count"];
          }.bind(this)
        });
      }

    },
    computed: {

    }
  });
});