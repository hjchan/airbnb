$(document).on('turbolinks:load', function(){
  console.log('ready')
  var form = document.querySelector('#cardForm');
  var submit = document.querySelector('#submit-payment-btn');
  var authorization = gon.clientToken

  braintree.client.create({
    authorization: authorization
  }, function (clientErr, clientInstance) {
    if (clientErr) {
      console.error(clientErr);
      return;
    }

    // This example shows Hosted Fields, but you can also use this
    // client instance to create additional components here, such as
    // PayPal or Data Collector.

    braintree.hostedFields.create({
      client: clientInstance,
      styles: {
        'input': {
          'font-size': '14px'
        },
        'input.invalid': {
          'color': 'red'
        },
        'input.valid': {
          'color': 'green'
        }
      },
      fields: {
        number: {
          selector: '#card-number',
          placeholder: '4111 1111 1111 1111'
        },
        cvv: {
          selector: '#cvv',
          placeholder: '123'
        },
        expirationDate: {
          selector: '#expiration-date',
          placeholder: '10/2019'
        }
      }
    }, function (hostedFieldsErr, hostedFieldsInstance) {
      if (hostedFieldsErr) {
        console.error(hostedFieldsErr);
        return;
      }

      submit.removeAttribute('disabled');

      form.addEventListener('submit', function (event) {
        event.preventDefault();
        hostedFieldsInstance.tokenize(function (tokenizeErr, payload) {
          if (tokenizeErr) {
            console.error(tokenizeErr);
            return;
          }

          // If this was a real integration, this is where you would
          // send the nonce to your server.
          document.querySelector('input[name="checkout_form[payment_method_nonce]"]').value = payload.nonce;
          form.submit();
        });
      }, false);
    });
  });
})