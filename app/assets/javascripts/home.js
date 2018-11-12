$(document).ready(function () {
  $('#server-side-table').DataTable({
    ajax: {
      url: '/get_processed_dataset',
      dataSrc: 'users',
    },
    serverSide: true,
    columns: [
      {title: 'First name', data: 'first_name', class: 'first-name-column'},
      {title: 'Last name', data: 'last_name', class: 'last-name-column'},
      {title: 'Birthday', data: 'birthday', class: 'birthday-column'},
      {title: 'Address', data: 'address', class: 'address-column'}
    ],
    order: [['0', 'desc']]
  });
});
