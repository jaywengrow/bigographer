/* global Vue */
document.addEventListener("DOMContentLoaded", function(event) { 
  var app = new Vue({
    el: '#app',
    data: {
      message: 'Hello Vue!',
      code: ''
    },
    mounted: function() {

    },
    methods: {
      analyzeCode: function() {
        Rails.ajax({
          url: "/api/v1/code",
          type: "POST",
          // data: "form_name=" + this.newPersonName + "&form_bio=" + this.newPersonBio,
          data: `code=${this.code}`,
          success: function(data) {
            console.log('success!!!', data);
            
          }.bind(this)
        });
      }

    },
    computed: {

    }
  });
});