<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'default.appointment.label', default: 'Appointment')}" />
    <title><g:message code="default.appointment.list.label"/></title>
    <asset:link rel="icon" href="favicon.ico" type="image/x-ico" />
</head>
<body>
<section id="students">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
                        <li class="breadcrumb-item active" aria-current="page"><g:message code="default.appointment.list.label"/></li>
                    </ol>
                </nav>
            </div>
            <div class="col-md-12">
                <g:form class="form" action="index" method="GET">
                    <div class="row">
                        <div class="form-group col-md-4">
                            <label for="doctor"><g:message code="default.doctor.label"/></label>
                            <g:select name="doctor" id="doctor"
                                      class="form-control"
                                      aria-hidden="true"
                                      from="${doctors}" value="${params?.doctor}" optionValue="fullName"
                                      optionKey="id"
                                      noSelection="['': 'Select']"
                                      style="width:100%"
                            />
                        </div>
                        <div class="form-group col-md-4">
                            <label for="medicalOffice"><g:message code="default.medicalOffice.label"/></label>
                            <g:select name="medicalOffice" id="medicalOffice"
                                      class="form-control"
                                      aria-hidden="true"
                                      from="${medicalOffices}" value="${params?.medicalOffice}" optionValue="room"
                                      optionKey="id"
                                      noSelection="['': 'Select']"
                                      style="width:100%"
                            />
                        </div>
                        <div class="form-group col-md-4">
                            <label for="startDate"><g:message code="default.date.label"/></label>
                            <div class="input-group date">
                                <input type="text" class="form-control date-picker" name="startDate" value="${params?.startDate}"
                                       id="startDate" required>
                                <div class="input-group-addon input-group-append">
                                    <div class="input-group-text">
                                        <i class="glyphicon glyphicon-calendar fa fa-calendar"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div>
                        <a href="${createLink(controller: 'appointment', action: 'index')}" class="btn btn-warning">
                            <i class="fa fa-times"></i> <g:message code="default.cancel.label" />
                        </a>
                        <button type="submit" class="btn btn-primary">
                            <i class="fa fa-filter"></i> <g:message code="default.filter.label"/>
                        </button>
                    </div>
                </g:form>
                <div class="col-lg-12 mt-2">
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
                <div class="card mt-2">
                    <div class="card-header">
                        <div class="row">
                            <div class="col-md-6">
                                <h4><g:message code="default.appointment.list.label"/></h4>
                            </div>
                            <div class="col-md-6">
                                <a href="${createLink(controller: 'appointment', action: 'create')}" class="btn btn-success float-right">
                                    <i class="fa fa-plus-circle"></i> <g:message code="default.new.label" args="[entityName]" />
                                </a>
                            </div>
                        </div>
                    </div>
                    <div class="card-body">
                        <table class="table table-bordered table-striped">
                            <thead class="bg-custom">
                            <tr>
                                <th></th>
                                <th><g:message code="default.doctor.label"/></th>
                                <th><g:message code="default.patient.label"/></th>
                                <th><g:message code="default.medicalOffice.label"/></th>
                                <th><g:message code="default.schedule.label"/></th>
                                <th><g:message code="default.cancel.label"/></th>
                            </tr>
                            </thead>
                            <tbody>
                            <g:each var="appointment" in="${appointmentsList}">
                                <tr>
                                    <td><a href="${createLink(controller: 'appointment', action: 'edit', id: appointment?.id)}"><i class="fa fa-search"></i></a></td>
                                    <td>${appointment?.doctor?.fullName}</td>
                                    <td>${appointment?.patientName}</td>
                                    <td>${appointment?.medicalOffice?.room}</td>
                                    <td><g:formatDate format="MM/dd/yyyy hh:mm aaa" date="${appointment?.startDate}"/> - <g:formatDate format="MM/dd/yyyy hh:mm aaa" date="${appointment?.endDate}"/></td>
                                    <td>
                                        <g:if test="${ !appointment?.isCanceled }">
                                            <a href="${ createLink( controller: 'appointment', action: 'cancel', id: appointment?.id ) }"><i class="fa fa-trash"></i></a>
                                        </g:if>
                                    </td>
                                </tr>
                            </g:each>
                            </tbody>
                        </table>
                        <div class="center">
                            <ul class="pagination">
                                <g:paginate total="${appointmentsListCount ?: 0}" params="${params}" />
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<script>
    $(document).ready(function () {
        $('.date-picker').datetimepicker({
            "allowInputToggle": true,
            "showClose": true,
            "showClear": true,
            "showTodayButton": true,
            "format": "MM/DD/YYYY",
        });
    });
</script>
</body>
</html>
