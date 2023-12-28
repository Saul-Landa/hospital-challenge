<!doctype html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Hospital</title>

    <asset:link rel="icon" href="favicon.ico" type="image/x-ico" />
</head>
<body>
<section>
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-header">
                        <h2>Welcome!</h2>
                        <span>In this web application you will be able to manage the information of a
                        hospital, select one of the following options or navigate through the menu:</span>
                    </div>
                    <div class="card-body">
                        <div class="list-group">
                            <a href="${ createLink(controller: 'appointment', action: 'index') }" class="list-group-item list-group-item-action">
                                Appointments
                            </a>
                            <a href="#" class="list-group-item list-group-item-action">
                                Doctors
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

</body>
</html>
