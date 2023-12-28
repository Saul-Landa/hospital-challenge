<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'default.appointment.label', default: 'Appointment')}" />
    <title><g:message code="default.appointment.list.label"/></title>
    <asset:link rel="icon" href="favicon.ico" type="image/x-ico" />
</head>
<body>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
                    <li class="breadcrumb-item"><a href="${createLink(controller: 'appointment', action: 'index')}"><g:message code="default.appointment.list.label"/></a></li>
                    <li class="breadcrumb-item active" aria-current="page"><g:message code="default.appointment.edit.label"/></li>
                </ol>
            </nav>
        </div>
        <div class="col">
            <div class="col-lg-12">
                <g:if test="${flash.message}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        ${flash.message}
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                </g:if>
                <g:if test="${flash.errors}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        ${flash.errors}
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                </g:if>
            </div>
            <div class="card">
                <div class="card-header">
                    <h4><g:message code="default.appointment.edit.label"/></h4>
                </div>
                <div class="card-body">
                    <g:form class="form" action="update" method="POST" id="${ appointment?.id }">
                        <g:render template="form"/>

                        <div class="float-right">
                            <button class="btn btn-primary" type="submit"><i class="fa fa-save"></i> <g:message code="default.save.label"/></button>
                        </div>
                    </g:form>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>