<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hospital</title>

    <link rel="stylesheet" href="https://netdna.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.css">
    <link crossorigin="anonymous" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
          rel="stylesheet">
    <asset:stylesheet src="app.css"/>
    <asset:stylesheet src="bootstrap-datetimepicker.min.css"/>

    <g:layoutHead/>
</head>
<body>
<header class="mb-3">
    <nav class="navbar navbar-expand-lg navbar-light bg-custom">
        <div class="container">
            <a class="navbar-brand" href="${ createLink(url: '/') }">Home</a>
            <button class="navbar-toggler" data-toggle="collapse" data-target="#navbarCollapse">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarCollapse">
                <ul class="navbar-nav">
                    <li class="nav-item px-2 ${controllerName == 'appointment' ? 'active' : ''}">
                        <a class="nav-link" href="${ createLink(controller: 'appointment', action: 'index') }">Appointments</a>
                    </li>
%{--                    <li class="nav-item px-2">--}%
%{--                        <a class="nav-link" href="#">Doctors</a>--}%
%{--                    </li>--}%
                </ul>
            </div>
        </div>
    </nav>
</header>

<section>
    <script crossorigin="anonymous" integrity="sha384-xBuQ/xzmlsLoJpyjoggmTEz8OWUFM0/RC5BsqQBDX2v5cMvDHcMakNTNrHIW2I5f" src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
    <script crossorigin="anonymous" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
    <script crossorigin="anonymous" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/moment.js/2.9.0/moment-with-locales.min.js"></script>
    <asset:javascript src="bootstrap-datetimepicker.min.js"/>
</section>

<g:layoutBody/>

<footer class="mt-2 p-2 fixed-bottom bg-custom">
    <div class="container">
        <div class="col">
            <p class="lead text-center">
                <span> All rights reserved &copy Saúl Landa</span>
            </p>
        </div>
    </div>
</footer>
</body>
</html>
