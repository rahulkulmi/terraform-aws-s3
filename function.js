"use strict";

function handler(event) {
  var request = event.request;
  var host = request.headers.host.value;

  if (request.uri.toLowerCase().includes("/api/")) {
    // request.headers.host.value = 
  }

  return request;
}
