$(document).on('turbolinks:load', function(){
	flatpickr("#user-birthday", {});
	// const startDate = flatpickr('#start-date',{
	// 	minDate: "today",
	// 	disable: gon.reservations,
	// 	onChange: function(selectedDates, dataStr, instance){
	// 		EndDate.set({minDate: new Date(dataStr).fp_incr(1)});
	// 		EndDate.open();
	// 	}
	// });
	flatpickr('#reservation-date',{
		minDate: "today",
		disable: gon.reservations,
		mode: "range"	
	});

})