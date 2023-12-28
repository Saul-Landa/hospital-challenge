<%@ page import="java.text.SimpleDateFormat" %>
<div class="row">
    <div class="form-group col-md-6">
        <label for="doctor"><g:message code="default.doctor.label"/></label>
        <g:select name="doctor" id="doctor"
                  class="form-control"
                  aria-hidden="true"
                  from="${doctors}" value="${appointment?.doctor?.id}" optionValue="fullName"
                  optionKey="id"
                  noSelection="['': 'Select']"
                  style="width:100%" required="required"
        />
    </div>
    <div class="form-group col-md-6">
        <label for="medicalOffice"><g:message code="default.medicalOffice.label"/></label>
        <g:select name="medicalOffice" id="medicalOffice"
                  class="form-control"
                  aria-hidden="true"
                  from="${medicalOffices}" value="${appointment?.medicalOffice?.id}" optionValue="room"
                  optionKey="id"
                  noSelection="['': 'Select']"
                  style="width:100%" required="required"
        />
    </div>
    <div class="form-group col-md-6">
        <label for="patient"><g:message code="default.patient.label"/></label>
        <input type="text" class="form-control" name="patientName" value="${appointment?.patientName}"
               id="patient" autocomplete="off" required>
    </div>
    <div class="form-group col-md-6">
        <%
            SimpleDateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy hh:mm:ss a")
        %>
        <label for="startDate"><g:message code="default.startDate.label"/></label>
        <div class="input-group date">
            <input type="text" class="form-control date-picker" name="startDate" value="${appointment?.startDate ? dateFormat.format(appointment?.startDate) : ''}"
                   id="startDate" required>
            <div class="input-group-addon input-group-append">
                <div class="input-group-text">
                    <i class="glyphicon glyphicon-calendar fa fa-calendar"></i>
                </div>
            </div>
        </div>
    </div>
    <div class="form-group col-md-6">
        <label for="endDate"><g:message code="default.endDate.label"/></label>
        <div class="input-group date">
            <input type="text" class="form-control date-picker" name="endDate" value="${appointment?.endDate ? dateFormat.format(appointment?.endDate) : ''}"
                   id="endDate" required>
            <div class="input-group-addon input-group-append">
                <div class="input-group-text">
                    <i class="glyphicon glyphicon-calendar fa fa-calendar"></i>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    $(document).ready(function () {
        $('.date-picker').datetimepicker({
            "allowInputToggle": true,
            "showClose": true,
            "showClear": true,
            "showTodayButton": true,
            "format": "MM/DD/YYYY hh:mm:ss A",
        });
    });
</script>