angular.module('Service', ['ngResource'])

.factory('Device', function($resource) {
	return $resource('/api/devices/:deviceId', {},
		{ get: { method: 'GET', params: { deviceId: 'deviceId'}}},
		{ query: { method: 'GET', isArray: true}}
	);
})

.factory('Job', function($resource) {
	return $resource('/api/jobs/:jobId', {},
	{
		get: { method: 'GET' },
		update: { method: 'PUT', params: {jobId: '@jobId'}},
		query: { method: 'GET', isArray: true}
	});
})

.factory('JobReport', function($resource) {
	return $resource('/api/job_reports/:reportId', {},
	{
		get: { method: 'GET' },
		query: { method: 'GET', isArray: true}
	});
})

.factory('Server', function($resource) {
	return $resource('/api/servers/:serverId', {},
		{ get: { method: 'GET', params: { serverId: 'serverId'}}},
		{ query: { method: 'GET', isArray: true }}
	);
})

.factory('Measurement', function($resource) {
	return $resource('/api/measurements/:measurementId', {},
		{ get: { method: 'GET', params: { measurementId: 'measurementId'}}},
		{ query: { method: 'GET'}}
	);
})

.factory('User', function($resource) {
	return $resource('/api/users/:userId', {},
		{ get: { method: 'GET', params: { userId: 'userId'}},
			query: { method: 'GET', isArray: true }
	});
})