function showNotification(data) {
	var notification = document.createElement('div')
	notification.className = 'notification';

	var title = document.createElement('div');
	title.className = 'title';
	title.innerHTML = data.title;
	notification.appendChild(title);

	if (data.text) {
		var text = document.createElement('div');
		text.className = 'text';
		text.innerHTML = data.text;
		notification.appendChild(text);
	}

	var notifications = document.querySelector('.notifications')
	notifications.appendChild(notification);

	// Show the notification
	setTimeout(function() {
		notification.classList.add('show');
	}, 100);

	// Hide the notification
	setTimeout(function() {
		notification.classList.add('hide');
	}, data.duration - 500);

	// Remove the notification from the DOM
	setTimeout(function() {
		notifications.removeChild(notification);
	}, data.duration);
}


window.addEventListener('message', function(event) {
	switch (event.data.type) {
		case 'showNotification':
			showNotification(event.data);
			break;
	}
});
