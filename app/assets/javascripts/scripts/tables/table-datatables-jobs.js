/**
 * DataTables
 */

$(function () {
  'use strict';

  var dt_jobs_table = $('.datatables-jobs')
  if (dt_jobs_table.length) {

    var dt_jobs = dt_jobs_table.DataTable({
      processing: true,
      serverSide: true,      
      ajax: dt_jobs_table.data('source'),
      columns: [
        {data: 'id'           },
        {data: 'category'     },
        {data: 'company'      },
        {data: 'city'         },
        {data: 'title'        },
        {data: 'published_at' },
        {data: 'actions'      }
      ],    
      columnDefs: [
        {
          targets: 0,
          visible: false
        },  
        {
          targets: 1,
          orderable: false,
          searchable: false
        }, 
        {
          targets: 3,
          orderable: false,
          searchable: false
        },                        
        {
          targets: -1,
          orderable: false,
          searchable: false,
          render: function (data, type, full, meta) {
            return (
              '<a href="javascript:;" class="item-edit">' +
                feather.icons['edit'].toSvg({ class: 'font-small-4' }) +
              '</a>'
            );
          }
        }
      ],
      order: [[5, 'desc']],
      dom: '<"d-flex justify-content-between align-items-center mx-0 row"<"col-sm-12 col-md-6"><"col-sm-12 col-md-6"f>>' + 
           't' + 
           '<"d-flex justify-content-between mx-0 row"<"col-sm-12 col-md-6"i><"col-sm-12 col-md-6"p>>',
      // responsive: {
      //   details: {
      //     display: $.fn.dataTable.Responsive.display.modal({
      //       header: function (row) {
      //         var data = row.data();
      //         return 'Details of ' + data['full_name'];
      //       }
      //     }),
      //     type: 'column',
      //     renderer: function (api, rowIdx, columns) {
      //       var data = $.map(columns, function (col, i) {
      //         return col.title !== '' // ? Do not show row in modal popup if title is blank (for check box)
      //           ? '<tr data-dt-row="' +
      //               col.rowIdx +
      //               '" data-dt-column="' +
      //               col.columnIndex +
      //               '">' +
      //               '<td>' +
      //               col.title +
      //               ':' +
      //               '</td> ' +
      //               '<td>' +
      //               col.data +
      //               '</td>' +
      //               '</tr>'
      //           : '';
      //       }).join('');

      //       return data ? $('<table class="table"/>').append('<tbody>' + data + '</tbody>') : false;
      //     }
      //   }
      // }
    });
  }

});
