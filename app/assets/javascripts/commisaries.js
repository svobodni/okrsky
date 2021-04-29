ready = function() {
  $('#new_commisary').cascadingDropdown({
    selectBoxes: [
      {
        selector: '.step1',
        paramName: 'region_id'
      },
      {
        selector: '.step2',
        requires: ['.step1'],
        paramName: 'municipality_id',
        source: function(request, response) {
          $.getJSON('/municipalities.json', request, function(data) {
            response($.map(data, function(item, index) {
              return {
                label: item['name'],
                value: item['id'],
                selected: index == 0
              };
            }));
          });
        }
      },
      {
        selector: '.step3',
        requires: ['.step2'],
        paramName: 'district_id',
        requireAll: true,
        source: function(request, response) {
          $.getJSON('/districts.json', request, function(data) {
            response($.map(data, function(item, index) {
              return {
                label: item['name'],
                value: item['id'],
                selected: index == 0
              };
            }));
          });
        }
      },
      {
        selector: '.step4',
        requires: ['.step2', '.step3'],
        requireAll: false,
        source: function(request, response) {
          $.getJSON('/wards.json', request, function(data) {
            response($.map(data, function(item, index) {
              return {
                label: item['name'],
                value: item['id']
              };
            }));
          });
        }
      }
    ]
  });
};

$(document).ready(ready);
$(document).on('page:load', ready);
$(document).on('turbolinks:load', ready);
