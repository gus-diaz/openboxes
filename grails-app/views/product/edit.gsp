<%@ page import="org.pih.warehouse.inventory.InventoryLevel; org.pih.warehouse.product.Product" %>
<html>
	<head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="custom" />
        <g:set var="entityName" value="${warehouse.message(code: 'product.label', default: 'Product')}" />

        <g:if test="${productInstance?.id}">
	        <title>${productInstance?.productCode } ${productInstance?.name }</title>
		</g:if>
		<g:else>
	        <title><warehouse:message code="product.add.label" /></title>	
			<content tag="label1"><warehouse:message code="inventory.label"/></content>
		</g:else>
		<link rel="stylesheet" href="${createLinkTo(dir:'js/jquery.tagsinput/',file:'jquery.tagsinput.css')}" type="text/css" media="screen, projection" />
		<script src="${createLinkTo(dir:'js/jquery.tagsinput/', file:'jquery.tagsinput.js')}" type="text/javascript" ></script>
        <style>
        #category_id_chosen {
            width: 100% !important;
        }
        </style>

    </head>
    <body>
        <div class="body">
            <g:if test="${flash.message}">
            	<div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${productInstance}">
	            <div class="errors">
	                <g:renderErrors bean="${productInstance}" as="list" />
	            </div>
            </g:hasErrors>
            
   			<g:if test="${productInstance?.id }">         
				<g:render template="summary" model="[productInstance:productInstance]"/>
			</g:if>
			
			<div style="padding: 10px">

                <div class="tabs tabs-ui">
					<ul>
						<li><a href="#tabs-details"><warehouse:message code="product.details.label"/></a></li>
						<%-- Only show these tabs if the product has been created --%>
						<g:if test="${productInstance?.id }">
                            <%--<li><a href="#tabs-manufacturer"><warehouse:message code="product.manufacturer.label"/></a></li>--%>
                            <li><a href="#tabs-status"><warehouse:message code="product.stockLevel.label" default="Stock levels"/></a></li>
                            <%--<li><a href="#tabs-tags"><warehouse:message code="product.tags.label"/></a></li>--%>
                            <li><a href="#tabs-synonyms"><warehouse:message code="product.synonyms.label"/></a></li>
                            <li><a href="#tabs-productGroups"><warehouse:message code="product.substitutions.label"/></a></li>
							<li><a href="#tabs-packages"><warehouse:message code="packages.label"/></a></li>
							<li><a href="#tabs-documents"><warehouse:message code="product.documents.label"/></a></li>
                            <li><a href="#tabs-attributes"><warehouse:message code="product.attributes.label" default="Attributes"/></a></li>

                            <g:if test="${productInstance?.id }">
                                <g:link controller='inventoryItem' action='showStockCard' id='${productInstance?.id }' class="button icon remove">
                                    ${warehouse.message(code: 'default.button.cancel.label', default: 'Cancel')}
                                </g:link>
                            </g:if>
                            <g:else>
                                <g:link controller="inventory" action="browse" class="button icon remove">
                                    ${warehouse.message(code: 'default.button.cancel.label', default: 'Cancel')}
                                </g:link>
                            </g:else>


                        </g:if>
					</ul>	
					<div id="tabs-details" style="padding: 10px;" class="ui-tabs-hide">
                        <g:set var="formAction"><g:if test="${productInstance?.id}">update</g:if><g:else>save</g:else></g:set>
                        <g:form action="${formAction}" method="post">
                            <g:hiddenField name="id" value="${productInstance?.id}" />
                            <g:hiddenField name="version" value="${productInstance?.version}" />
                            <g:hiddenField name="categoryId" value="${params?.category?.id }"/>
                            <!--  So we know which category to show on browse page after submit -->

                            <div class="box" >
                                <h2>
                                    <warehouse:message code="product.productDetails.label" default="Product details"/>
                                </h2>
                                <table>
                                    <tbody>
                                        <tr class="prop first">
                                            <td class="name middle"><label for="productCode"><warehouse:message
                                                    code="product.productCode.label"/></label>

                                            </td>
                                            <td valign="top" class="value ${hasErrors(bean: productInstance, field: 'productCode', 'errors')}">
                                                <g:textField name="productCode" value="${productInstance?.productCode}" size="50" class="medium text"
                                                             placeholder="${warehouse.message(code:'product.productCode.placeholder') }"/>
                                            </td>
                                        </tr>

                                        <tr class="prop first">
                                            <td class="name middle"><label for="name"><warehouse:message
                                                code="product.title.label" /></label></td>
                                            <td valign="top"
                                                class="value ${hasErrors(bean: productInstance, field: 'name', 'errors')}">
                                                <%--
                                                <g:textField name="name" value="${productInstance?.name}" size="80" class="medium text" />
                                                --%>
                                                <g:autoSuggestString id="name" name="name" size="80" class="text"
                                                    jsonUrl="${request.contextPath}/json/autoSuggest" value="${productInstance?.name?.encodeAsHTML()}"
                                                    placeholder="Product title (e.g. Ibuprofen, 200 mg, tablet)"/>
                                            </td>
                                        </tr>

                                        <tr class="prop">
                                            <td class="name middle">
                                              <label for="category.id"><warehouse:message code="product.primaryCategory.label" /></label>
                                            </td>
                                            <td valign="top" class="value ${hasErrors(bean: productInstance, field: 'category', 'errors')}">
                                                <g:selectCategory name="category.id" class="chzn-select" noSelection="['null':'']"
                                                                     value="${productInstance?.category?.id}" />


                                           </td>
                                        </tr>

                                        <tr class="prop">
                                            <td class="name middle"><label for="unitOfMeasure"><warehouse:message
                                                code="product.unitOfMeasure.label" /></label></td>
                                            <td
                                                class="value ${hasErrors(bean: productInstance, field: 'unitOfMeasure', 'errors')}">
                                                <%--
                                                <g:textField name="unitOfMeasure" value="${productInstance?.unitOfMeasure}" size="15" class="medium text"/>
                                                --%>
                                                <g:autoSuggestString id="unitOfMeasure" name="unitOfMeasure" size="80" class="text"
                                                    jsonUrl="${request.contextPath}/json/autoSuggest"
                                                    value="${productInstance?.unitOfMeasure}" placeholder="e.g. each, tablet, tube, vial"/>
                                            </td>
                                        </tr>

                                        <tr class="prop">
                                            <td class="name top"><label for="description"><warehouse:message
                                                code="product.description.label" /></label></td>
                                            <td
                                                class="value ${hasErrors(bean: productInstance, field: 'description', 'errors')}">
                                                <g:textArea name="description" value="${productInstance?.description}" class="medium text"
                                                    cols="80" rows="10"
                                                    placeholder="Detailed text description (optional)" />
                                            </td>
                                        </tr>
                                        <tr class="prop">
                                            <td class="name middle"><label for="upc"><warehouse:message
                                                    code="product.upc.label" /></label></td>
                                            <td class="value ${hasErrors(bean: productInstance, field: 'upc', 'errors')}">
                                                <g:textField name="upc" value="${productInstance?.upc}" size="50" class="medium text"/>
                                            </td>
                                        </tr>
                                        <tr class="prop">
                                            <td class="name middle"><label for="ndc"><warehouse:message
                                                    code="product.ndc.label" /></label></td>
                                            <td class="value ${hasErrors(bean: productInstance, field: 'ndc', 'errors')}">
                                                <g:textField name="ndc" value="${productInstance?.ndc}" size="50" class="medium text"
                                                             placeholder="e.g. 0573-0165"/>
                                            </td>
                                        </tr>
                                    <tr class="prop">
                                        <td class="name">
                                            <label><warehouse:message code="product.tags.label" default="Tags"></warehouse:message></label>
                                        </td>
                                        <td class="value">
                                            <g:textField id="tags1" class="tags" name="tagsToBeAdded" value="${productInstance?.tagsToString() }"/>
                                            <script>
                                                $(function() {
                                                    $('#tags1').tagsInput({
                                                        'autocomplete_url':'${createLink(controller: 'json', action: 'findTags')}',
                                                        'width': 'auto',
                                                        'height': '20px',
                                                        'removeWithBackspace' : true
                                                    });
                                                });
                                            </script>
                                        </td>
                                    </tr>

                                        <tr class="prop">
                                            <td class="name">
                                                <label><warehouse:message code="product.status.label" default="Status"/></label>
                                            </td>
                                            <td class="value ${hasErrors(bean: productInstance, field: 'active', 'errors')} ${hasErrors(bean: productInstance, field: 'essential', 'errors')}">
                                                <table>
                                                    <tr>
                                                        <td width="25%">

                                                            <g:checkBox name="active" value="${productInstance?.active}" />
                                                            <label for="active"><warehouse:message
                                                            code="product.active.label" /></label>
                                                        </td>
                                                        <td width="25%">
                                                            <g:checkBox name="essential" value="${productInstance?.essential}" />
                                                            <label for="essential"><warehouse:message
                                                                    code="product.essential.label" /></label>

                                                        </td>
                                                        <td width="25%">
                                                        </td>
                                                        <td width="25%">
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>

                                        <tr class="prop">
                                            <td class="name">
                                                <label><warehouse:message code="product.handlingRequirements.label" default="Handling requirements"></warehouse:message></label>
                                            </td>
                                            <td class="value ${hasErrors(bean: productInstance, field: 'coldChain', 'errors')} ${hasErrors(bean: productInstance, field: 'controlledSubstance', 'errors')} ${hasErrors(bean: productInstance, field: 'hazardousMaterial', 'errors')}">
                                                <table>
                                                    <tr>
                                                        <td width="25%">
                                                            <g:checkBox name="coldChain" value="${productInstance?.coldChain}" />
                                                            <label for="coldChain"><warehouse:message
                                                                code="product.coldChain.label" /></label>
                                                        </td>

                                                        <td width="25%">
                                                            <g:checkBox name="controlledSubstance" value="${productInstance?.controlledSubstance}" />
                                                            <label for="controlledSubstance"><warehouse:message
                                                                code="product.controlledSubstance.label" /></label>
                                                        </td>

                                                        <td width="25%">
                                                            <g:checkBox name="hazardousMaterial" value="${productInstance?.hazardousMaterial}" />
                                                            <label for="hazardousMaterial"><warehouse:message
                                                                code="product.hazardousMaterial.label" /></label>
                                                        </td>

                                                        <td width="25%">
                                                            <g:checkBox name="reconditioned" value="${productInstance?.reconditioned}" />
                                                            <label for="reconditioned"><warehouse:message
                                                                    code="product.reconditioned.label" default="Reconditioned"/></label>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr class="prop">
                                            <td class="name">
                                                <label><warehouse:message code="product.inventoryControl.label" default="Inventory control"></warehouse:message></label>
                                            </td>
                                            <td class="value ${hasErrors(bean: productInstance, field: 'lotControl', 'errors')}">
                                                <table>
                                                    <tr>
                                                        <td width="25%">
                                                            <g:checkBox name="serialized" value="${productInstance?.serialized}" />
                                                            <label for="serialized"><warehouse:message
                                                                code="product.serialized.label" /></label>
                                                        </td>

                                                        <td width="25%">
                                                            <g:checkBox name="lotControl" value="${productInstance?.lotControl}" />
                                                            <label for="lotControl"><warehouse:message
                                                                code="product.lotControl.label" /></label>
                                                        </td>
                                                        <td width="25%">
                                                        </td>
                                                        <td width="25%">
                                                        </td>
                                                    </tr>
                                                </table>

                                            </td>
                                        </tr>
                                    </tbody>

                                </table>
                            </div>
                            
                            <div class="box">

                                <h2>
                                    <warehouse:message code="product.manufacturerDetails.label" default="Manufacturer details"/>
                                </h2>

                                <table>
                                    <tbody>
                                    <tr class="prop">
                                        <td class="name middle"><label for="brandName"><warehouse:message
                                                code="product.brandName.label" /></label></td>
                                        <td
                                                class="value ${hasErrors(bean: productInstance, field: 'brandName', 'errors')}">
                                            <g:autoSuggestString id="brandName" name="brandName" size="50" class="text"
                                                                 jsonUrl="${request.contextPath}/json/autoSuggest"
                                                                 value="${productInstance?.brandName}"
                                                                 placeholder="e.g. Advil, Tylenol"/>
                                        </td>
                                    </tr>
                                    <tr class="prop">
                                        <td class="name middle"><label for="manufacturer"><warehouse:message
                                                code="product.manufacturer.label" /></label></td>
                                        <td
                                            class="value ${hasErrors(bean: productInstance, field: 'manufacturer', 'errors')}">
                                            <%--
                                            <g:textField name="unitOfMeasure" value="${productInstance?.manufacturer}" size="60" class="medium text"/>
                                            --%>
                                            <g:autoSuggestString id="manufacturer" name="manufacturer" size="50" class="text"
                                                                 jsonUrl="${request.contextPath}/json/autoSuggest"
                                                                 value="${productInstance?.manufacturer}"
                                                                 placeholder="e.g. Pfizer, Beckton Dickson"/>

                                        </td>
                                    </tr>

                                    <tr class="prop">
                                        <td class="name middle"><label for="manufacturerCode"><warehouse:message
                                                code="product.manufacturerCode.label"/></label></td>
                                        <td class="value ${hasErrors(bean: productInstance, field: 'manufacturerCode', 'errors')}">
                                            <g:textField name="manufacturerCode" value="${productInstance?.manufacturerCode}" size="50" class="text"/>
                                            <%--
                                            <g:autoSuggestString id="manufacturerCode" name="manufacturerCode" size="50" class="text"
                                                jsonUrl="${request.contextPath}/json/autoSuggest"
                                                value="${productInstance?.manufacturerCode}"
                                                placeholder=""/>
                                            --%>
                                        </td>
                                    </tr>
                                    <tr class="prop">
                                        <td class="name middle"><label for="manufacturerName"><warehouse:message
                                                code="product.manufacturerName.label"/></label></td>
                                        <td class="value ${hasErrors(bean: productInstance, field: 'manufacturerName', 'errors')}">
                                            <g:textField name="manufacturerName" value="${productInstance?.manufacturerName}" size="50" class="text"/>
                                            <%--
                                            <g:autoSuggestString id="manufacturerName" name="manufacturerName" size="50" class="text"
                                                jsonUrl="${request.contextPath}/json/autoSuggest"
                                                value="${productInstance?.manufacturerName}"
                                                placeholder=""/>
                                            --%>
                                        </td>
                                    </tr>


                                    <tr class="prop">
                                        <td class="name middle"><label for="modelNumber"><warehouse:message
                                                code="product.modelNumber.label" /></label></td>
                                        <td
                                            class="value ${hasErrors(bean: productInstance, field: 'modelNumber', 'errors')}">
                                            <g:textField name="modelNumber" value="${productInstance?.modelNumber}" size="50" class="text"/>
                                            <%--
                                            <g:autoSuggestString id="modelNumber" name="modelNumber" size="50" class="text"
                                                jsonUrl="${request.contextPath}/json/autoSuggest"
                                                value="${productInstance?.modelNumber}" promptOnMatch="true"
                                                placeholder="e.g. Usually only pertains to equipment "/>
                                            --%>
                                        </td>
                                    </tr>

                                    <tr class="prop">
                                        <td class="name middle"><label for="vendor"><warehouse:message
                                                code="product.vendor.label" /></label></td>
                                        <td
                                            class="value ${hasErrors(bean: productInstance, field: 'vendor', 'errors')}">
                                            <g:autoSuggestString id="vendor" name="vendor" size="50" class="text"
                                                                 jsonUrl="${request.contextPath}/json/autoSuggest"
                                                                 value="${productInstance?.vendor}"
                                                                 placeholder="e.g. IDA, IMRES, McKesson"/>

                                        </td>
                                    </tr>
                                    <tr class="prop">
                                        <td class="name middle"><label for="vendorCode"><warehouse:message
                                                code="product.vendorCode.label"/></label></td>
                                        <td class="value ${hasErrors(bean: productInstance, field: 'vendorCode', 'errors')}">
                                            <g:textField name="vendorCode" value="${productInstance?.vendorCode}" size="50" class="text"/>
                                            <%--
                                            <g:autoSuggestString id="vendorCode" name="vendorCode" size="50" class="text"
                                                jsonUrl="${request.contextPath}/json/autoSuggest"
                                                value="${productInstance?.vendorCode}"
                                                placeholder=""/>
                                            --%>
                                        </td>
                                    </tr>
                                    <tr class="prop">
                                        <td class="name middle"><label for="vendorName"><warehouse:message
                                                code="product.vendorName.label"/></label></td>
                                        <td class="value ${hasErrors(bean: productInstance, field: 'vendorName', 'errors')}">
                                            <g:textField name="vendorName" value="${productInstance?.vendorName}" size="50" class="text"/>
                                            <%--
                                            <g:autoSuggestString id="vendorName" name="vendorName" size="50" class="text"
                                                jsonUrl="${request.contextPath}/json/autoSuggest"
                                                value="${productInstance?.vendorName}"
                                                placeholder=""/>
                                            --%>

                                        </td>
                                    </tr>
                                    <tr class="prop">
                                        <td class="name middle"><label for="pricePerUnit"><warehouse:message
                                                code="product.pricePerUnit.label"/></label></td>
                                        <td class="value middle ${hasErrors(bean: productInstance, field: 'pricePerUnit', 'errors')}">
                                            <g:textField name="pricePerUnit" placeholder="Price per unit (${grailsApplication.config.openboxes.locale.defaultCurrencyCode})"
                                                         value="${g.formatNumber(number:productInstance?.pricePerUnit, format:'###,###,##0.####') }"
                                                         class="text" size="50" />

                                            <span class="fade">${grailsApplication.config.openboxes.locale.defaultCurrencyCode}</span>

                                        </td>
                                    </tr>



                                        <%--
                                        <tr class="prop">
                                            <td class="name"><label for="name"><warehouse:message
                                                code="product.genericName.label" /></label></td>
                                            <td
                                                class="value ${hasErrors(bean: productInstance, field: 'genericProducts', 'errors')}">
                                                <ul>
                                                    <g:each var="productGroup" in="${productInstance?.productGroups }">
                                                        <li>
                                                            ${productGroup.description }
                                                            <g:link controller="productGroup" action="edit" id="${productGroup.id }">
                                                                <warehouse:message code="default.button.edit.label"/>
                                                            </g:link>
                                                        </li>
                                                    </g:each>
                                                </ul>
                                            </td>
                                        </tr>
                                        --%>

                                    </tbody>

                                </table>
                            </div>
                            <div class="center">
                                <button type="submit" class="button icon approve">
                                    ${warehouse.message(code: 'default.button.save.label', default: 'Save')}
                                </button>
                                &nbsp;
                                <g:if test="${productInstance?.id }">
                                    <g:link controller='inventoryItem' action='showStockCard' id='${productInstance?.id }' class="button icon remove">
                                        ${warehouse.message(code: 'default.button.cancel.label', default: 'Cancel')}
                                    </g:link>
                                </g:if>
                                <g:else>
                                    <g:link controller="inventory" action="browse" class="button icon remove">
                                        ${warehouse.message(code: 'default.button.cancel.label', default: 'Cancel')}
                                    </g:link>
                                </g:else>
                            </div>


                        </g:form>
                    </div>


                    <%-- Only show these tabs if the product has been created --%>
                    <g:if test="${productInstance?.id }">
                        <%--
                        <div id="tabs-tags" style="padding: 10px;" class="ui-tabs-hide">
                            <g:form controller="product" action="updateTags" method="post">
                                <g:hiddenField name="action" value="save"/>
                                <g:hiddenField name="id" value="${productInstance?.id}" />
                                <g:hiddenField name="version" value="${productInstance?.version}" />
                                <div class="box" >
                                    <h2>
                                        <warehouse:message code="product.tags.label" default="Product tags"/>
                                    </h2>
                                    <table>
                                        <tbody>
                                            <tr class="prop">

                                                <td class="value">
                                                    <g:textField id="tags1" class="tags" name="tagsToBeAdded" value="${productInstance?.tagsToString() }"/>
                                                    <script>
                                                        $(function() {
                                                            $('#tags1').tagsInput({
                                                                'autocomplete_url':'${createLink(controller: 'json', action: 'findTags')}',
                                                                'width': 'auto',
                                                                'height': '20px',
                                                                'removeWithBackspace' : true
                                                            });
                                                        });
                                                    </script>
                                                </td>
                                            </tr>
                                        </tbody>
                                        <tfoot>
                                            <tr>
                                                <td colspan="2">
                                                    <div class="center">
                                                        <button type="submit" class="button icon approve">
                                                            ${warehouse.message(code: 'default.button.save.label', default: 'Save')}
                                                        </button>
                                                        &nbsp;
                                                        <g:if test="${productInstance?.id }">
                                                            <g:link controller='inventoryItem' action='showStockCard' id='${productInstance?.id }' class="button icon arrowright">
                                                                ${warehouse.message(code: 'default.button.done.label', default: 'Done')}
                                                            </g:link>
                                                        </g:if>
                                                        <g:else>
                                                            <g:link controller="inventory" action="browse" class="button icon arrowright">
                                                                ${warehouse.message(code: 'default.button.done.label', default: 'Done')}
                                                            </g:link>
                                                        </g:else>
                                                    </div>

                                                </td>
                                            </tr>
                                        </tfoot>
                                    </table>

                                </div>
                            </g:form>
                        </div>

                        <div id="tabs-manufacturer" style="padding: 10px;" class="ui-tabs-hide">

                            <g:form action="update" method="post">
                                <g:hiddenField name="action" value="save"/>
                                <g:hiddenField name="id" value="${productInstance?.id}" />
                                <g:hiddenField name="version" value="${productInstance?.version}" />
                                <g:hiddenField name="categoryId" value="${params?.category?.id }"/>
                                <div class="box">
                                    <h2>
                                        <warehouse:message code="product.manufacturerDetails.label" default="Manufacturer details"/>
                                    </h2>
                                    <table>
                                        <tbody>
                                        <tr class="prop">
                                            <td class="name"><label for="manufacturer"><warehouse:message
                                                    code="product.manufacturer.label" /></label></td>
                                            <td
                                                class="value ${hasErrors(bean: productInstance, field: 'manufacturer', 'errors')}">
                                                <g:autoSuggestString id="manufacturer" name="manufacturer" size="50" class="text"
                                                                     jsonUrl="${request.contextPath}/json/autoSuggest"
                                                                     value="${productInstance?.manufacturer}"
                                                                     placeholder="e.g. Pfizer, Beckton Dickson"/>

                                            </td>
                                        </tr>
                                        <tr class="prop">
                                            <td class="name"><label for="brandName"><warehouse:message
                                                    code="product.brandName.label" /></label></td>
                                            <td
                                                class="value ${hasErrors(bean: productInstance, field: 'brandName', 'errors')}">
                                                <g:autoSuggestString id="brandName" name="brandName" size="50" class="text"
                                                                     jsonUrl="${request.contextPath}/json/autoSuggest"
                                                                     value="${productInstance?.brandName}"
                                                                     placeholder="e.g. Advil, Tylenol"/>
                                            </td>
                                        </tr>

                                        <tr class="prop">
                                            <td class="name"><label for="manufacturerCode"><warehouse:message
                                                    code="product.manufacturerCode.label"/></label></td>
                                            <td class="value ${hasErrors(bean: productInstance, field: 'manufacturerCode', 'errors')}">
                                                <g:textField name="manufacturerCode" value="${productInstance?.manufacturerCode}" size="50" class="text"/>

                                            </td>
                                        </tr>
                                        <tr class="prop">
                                            <td class="name"><label for="manufacturerName"><warehouse:message
                                                    code="product.manufacturerName.label"/></label></td>
                                            <td class="value ${hasErrors(bean: productInstance, field: 'manufacturerName', 'errors')}">
                                                <g:textField name="manufacturerName" value="${productInstance?.manufacturerName}" size="50" class="text"/>

                                            </td>
                                        </tr>


                                        <tr class="prop">
                                            <td class="name"><label for="modelNumber"><warehouse:message
                                                    code="product.modelNumber.label" /></label></td>
                                            <td
                                                class="value ${hasErrors(bean: productInstance, field: 'modelNumber', 'errors')}">
                                                <g:textField name="modelNumber" value="${productInstance?.modelNumber}" size="50" class="text"/>

                                            </td>
                                        </tr>

                                        <tr class="prop">
                                            <td class="name"><label for="vendor"><warehouse:message
                                                    code="product.vendor.label" /></label></td>
                                            <td
                                                class="value ${hasErrors(bean: productInstance, field: 'vendor', 'errors')}">
                                                <g:autoSuggestString id="vendor" name="vendor" size="50" class="text"
                                                                     jsonUrl="${request.contextPath}/json/autoSuggest"
                                                                     value="${productInstance?.vendor}"
                                                                     placeholder="e.g. IDA, IMRES, McKesson"/>

                                            </td>
                                        </tr>
                                        <tr class="prop">
                                            <td class="name"><label for="vendorCode"><warehouse:message
                                                    code="product.vendorCode.label"/></label></td>
                                            <td class="value ${hasErrors(bean: productInstance, field: 'vendorCode', 'errors')}">
                                                <g:textField name="vendorCode" value="${productInstance?.vendorCode}" size="50" class="text"/>

                                            </td>
                                        </tr>
                                        <tr class="prop">
                                            <td class="name"><label for="vendorName"><warehouse:message
                                                    code="product.vendorName.label"/></label></td>
                                            <td class="value ${hasErrors(bean: productInstance, field: 'vendorName', 'errors')}">
                                                <g:textField name="vendorName" value="${productInstance?.vendorName}" size="50" class="text"/>


                                            </td>
                                        </tr>
                                        <tr class="prop">
                                            <td class="name"><label for="pricePerUnit"><warehouse:message
                                                    code="product.pricePerUnit.label"/></label></td>
                                            <td class="value middle ${hasErrors(bean: productInstance, field: 'pricePerUnit', 'errors')}">
                                                <g:textField name="pricePerUnit"
                                                             value="${g.formatNumber(number:productInstance?.pricePerUnit, format:'###,##0.##') }" class="text" size="10" />

                                                USD per ${productInstance?.unitOfMeasure?:warehouse.message(code:'default.each.label')}
                                            </td>
                                        </tr>




                                        </tbody>
                                        <tfoot>
                                            <tr>
                                                <td colspan="2">
                                                    <div class="center">
                                                        <button type="submit" class="button icon approve">
                                                            ${warehouse.message(code: 'default.button.save.label', default: 'Save')}
                                                        </button>
                                                        &nbsp;
                                                        <g:if test="${productInstance?.id }">
                                                            <g:link controller='inventoryItem' action='showStockCard' id='${productInstance?.id }' class="button icon arrowright">
                                                                ${warehouse.message(code: 'default.button.done.label', default: 'Done')}
                                                            </g:link>
                                                        </g:if>
                                                        <g:else>
                                                            <g:link controller="inventory" action="browse" class="button icon arrowright">
                                                                ${warehouse.message(code: 'default.button.done.label', default: 'Done')}
                                                            </g:link>
                                                        </g:else>
                                                    </div>
                                                </td>
                                            </tr>

                                        </tfoot>
                                    </table>
                                </div>
                            </g:form>
                        </div>
                        --%>

                        <div id="tabs-synonyms" style="padding: 10px;" class="ui-tabs-hide">
                            <div class="box">
                                <h2><warehouse:message code="product.synonyms.label" default="Synonyms"/></h2>
                                <g:render template="synonyms" model="[product: productInstance, synonyms:productInstance?.synonyms]"/>
                            </div>
                        </div>

                        <div id="tabs-productGroups" style="padding: 10px;" class="ui-tabs-hide">
                            <div class="box">
                                <h2><warehouse:message code="product.substitutions.label" default="Substitutions"/></h2>
                                <g:render template="productGroups" model="[product: productInstance, productGroups:productInstance?.productGroups]"/>
                            </div>
                        </div>


                        <div id="tabs-attributes" style="padding: 10px;" class="ui-tabs-hide">
                            <g:form action="update" method="post">
                                <g:hiddenField name="action" value="save"/>
                                <g:hiddenField name="id" value="${productInstance?.id}" />
                                <g:hiddenField name="version" value="${productInstance?.version}" />
                                <div class="box" >
                                    <h2>
                                        <warehouse:message code="product.attributes.label" default="Product attributes"/>
                                    </h2>

                                    <g:set var="attributes" value="${org.pih.warehouse.product.Attribute.list()}"/>
                                    <g:unless test="${attributes}">
                                        <div class="empty center">
                                            There are no attributes
                                        </div>

                                    </g:unless>

                                    <table>
                                        <tbody>
                                            <g:each var="attribute" in="${attributes}" status="status">
                                                <tr class="prop">
                                                    <td class="name">
                                                        <label for="productAttributes.${attribute?.id}.value"><format:metadata obj="${attribute}"/></label>
                                                    </td>
                                                    <td class="value">
                                                        <g:set var="attributeFound" value="f"/>
                                                        <g:if test="${attribute.options}">
                                                            <select name="productAttributes.${attribute?.id}.value" class="attributeValueSelector">
                                                                <option value=""></option>
                                                                <g:each var="option" in="${attribute.options}" status="optionStatus">
                                                                    <g:set var="selectedText" value=""/>
                                                                    <g:if test="${productInstance?.attributes[status]?.value == option}">
                                                                        <g:set var="selectedText" value=" selected"/>
                                                                        <g:set var="attributeFound" value="t"/>
                                                                    </g:if>
                                                                    <option value="${option}"${selectedText}>${option}</option>
                                                                </g:each>
                                                                <g:set var="otherAttVal" value="${productInstance?.attributes[status]?.value != null && attributeFound == 'f'}"/>
                                                                <g:if test="${attribute.allowOther || otherAttVal}">
                                                                    <option value="_other"<g:if test="${otherAttVal}"> selected</g:if>>
                                                                        <g:message code="product.attribute.value.other" default="Other..." />
                                                                    </option>
                                                                </g:if>
                                                            </select>
                                                        </g:if>
                                                        <g:set var="onlyOtherVal" value="${attribute.options.isEmpty() && attribute.allowOther}"/>
                                                        <g:textField class="otherAttributeValue" style="${otherAttVal || onlyOtherVal ? '' : 'display:none;'}" name="productAttributes.${attribute?.id}.otherValue" value="${otherAttVal || onlyOtherVal ? productInstance?.attributes[status]?.value : ''}"/>
                                                    </td>
                                                </tr>
                                            </g:each>
                                        </tbody>
                                        <tfoot>
                                            <tr>
                                                <td colspan="2">
                                                    <div class="center">

                                                        <button type="submit" class="button icon approve">
                                                            ${warehouse.message(code: 'default.button.save.label', default: 'Save')}
                                                        </button>
                                                        &nbsp;
                                                        <g:if test="${productInstance?.id }">
                                                            <g:link controller='inventoryItem' action='showStockCard' id='${productInstance?.id }' class="">
                                                                ${warehouse.message(code: 'default.button.cancel.label', default: 'Cancel')}
                                                            </g:link>
                                                        </g:if>
                                                        <g:else>
                                                            <g:link controller="inventory" action="browse" class="">
                                                                ${warehouse.message(code: 'default.button.cancel.label', default: 'Cancel')}
                                                            </g:link>
                                                        </g:else>
                                                    </div>
                                                </td>
                                            </tr>

                                        </tfoot>
                                    </table>

                                </g:form>
                            </div>
                        </div>


                        <div id="tabs-status" style="padding: 10px;" class="ui-tabs-hide">
				            <g:hasErrors bean="${inventoryLevelInstance}">
					            <div class="errors">
					                <g:renderErrors bean="${inventoryLevelInstance}" as="list" />
					            </div>
				            </g:hasErrors>

							<g:form controller="product" action="updateInventoryLevels">
                                <div class="box">

                                    <h2>
                                        <warehouse:message code="product.stockLevels.label" default="Stock levels"/>
                                    </h2>
                                    <table>
                                        <thead>
                                            <tr class="odd">
                                                <th><warehouse:message code="inventoryLevel.status.label"/></th>
                                                <th><warehouse:message code="inventory.label"/></th>
                                                <th><warehouse:message code="inventoryLevel.binLocation.label"/></th>
                                                <th class="center"><warehouse:message code="inventoryLevel.abcClass.label" default="ABC Class"/></th>
                                                <th class="center"><warehouse:message code="inventoryLevel.minQuantity.label"/></th>
                                                <th class="center"><warehouse:message code="inventoryLevel.reorderQuantity.label"/></th>
                                                <th class="center"><warehouse:message code="inventoryLevel.maxQuantity.label"/></th>
                                                <th class="center"><warehouse:message code="inventoryLevel.preferred.label"/></th>
                                                <th class="center"><warehouse:message code="default.lastUpdated.label"/></th>
                                                <th><warehouse:message code="default.actions.label"/></th>
                                            </tr>
                                        </thead>
                                        <tbody>

                                            <g:each var="inventoryLevelInstance" in="${productInstance?.inventoryLevels}" status="i">

                                                <tr class="prop ${i%2?'even':'odd'}">
                                                    <td>
                                                        <%--
                                                        <g:select name="inventoryLevels[${i}].status"
                                                           from="${org.pih.warehouse.inventory.InventoryStatus.list()}"
                                                           optionValue="${{format.metadata(obj:it)}}" value="${inventoryLevelInstance?.status}"
                                                           noSelection="['':warehouse.message(code:'inventoryLevel.chooseStatus.label')]" />&nbsp;&nbsp;
                                                        --%>
                                                        ${inventoryLevelInstance?.status}
                                                    </td>
                                                    <td>
                                                        ${inventoryLevelInstance?.inventory?.warehouse?.name }
                                                        <%--<g:hiddenField name="inventoryLevels[${i}].inventory.id" value="${inventoryLevelInstance?.id}"/>--%>
                                                    </td>
                                                    <td>
                                                        <%--
                                                        <g:textField name="inventoryLevels[${i}].binLocation"
                                                            value="${inventoryLevelInstance?.binLocation }" size="20" class="text"/>
                                                        --%>
                                                        ${inventoryLevelInstance?.binLocation}
                                                    </td>
                                                    <td class="center">
                                                        ${inventoryLevelInstance?.abcClass?:warehouse.message(code:'default.none.label')}
                                                    </td>
                                                    <td class="center">
                                                        <%--<g:textField name="inventoryLevels[${i}].minQuantity" value="${inventoryLevelInstance?.minQuantity }" size="10" class="text"/>--%>
                                                        ${inventoryLevelInstance?.minQuantity?:0 }
                                                        ${productInstance?.unitOfMeasure?:warehouse.message(code:'default.each.label')}
                                                    </td>
                                                    <td class="center">
                                                        <%--<g:textField name="inventoryLevels[${i}].reorderQuantity" value="${inventoryLevelInstance?.reorderQuantity }" size="10" class="text"/>--%>
                                                        ${inventoryLevelInstance?.reorderQuantity?:0 }
                                                        ${productInstance?.unitOfMeasure?:warehouse.message(code:'default.each.label')}
                                                    </td>
                                                    <td class="center">
                                                        <%--<g:textField name="inventoryLevels[${i}].maxQuantity" value="${inventoryLevelInstance?.maxQuantity }" size="10" class="text"/>--%>
                                                        ${inventoryLevelInstance?.maxQuantity?:0 }
                                                        ${productInstance?.unitOfMeasure?:warehouse.message(code:'default.each.label')}
                                                    </td>
                                                    <td class="center">
                                                        ${inventoryLevelInstance?.preferred }
                                                    </td>
                                                    <td class="center">
                                                        <g:formatDate date="${inventoryLevelInstance?.lastUpdated }"/>
                                                    </td>

                                                    <td>
                                                        <%--
                                                        <g:link controller="inventoryLevel" action="edit" id="${inventoryLevelInstance?.id}">
                                                            <img src="${createLinkTo(dir:'images/icons/silk', file: 'pencil.png')}"/></g:link>
                                                        --%>
                                                        <div class="button-group">

                                                            <a href="javascript:void(0);" class="open-dialog create button icon edit" dialog-id="inventory-level-${inventoryLevelInstance?.id}-dialog">
                                                                ${warehouse.message(code:'default.button.edit.label')}</a>

                                                            <g:link controller="inventoryLevel" action="clone" class="button icon settings" id="${inventoryLevelInstance?.id}">
                                                                ${warehouse.message(code:'default.button.clone.label')}</g:link>

                                                            <g:link controller="inventoryLevel" action="delete" class="button icon remove" id="${inventoryLevelInstance?.id}">
                                                                ${warehouse.message(code:'default.button.delete.label')}</g:link>

                                                        </div>
                                                    </td>
                                                </tr>
                                            </g:each>
                                            <g:unless test="${productInstance?.inventoryLevels}">
                                                <tr>
                                                    <td colspan="10" class="center">
                                                        <div class="empty center">
                                                            <warehouse:message code="product.hasNoInventoryLevels.label" default="There are no stock levels"/>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </g:unless>
                                        </tbody>
                                        <tfoot>
                                            <tr class="prop">
                                                <td colspan="10" class="center">

                                                    <a href="javascript:void(0);" class="open-dialog create button icon add" dialog-id="inventory-level-dialog">
                                                        ${warehouse.message(code:'inventoryLevel.create.label', default: 'Create new stock level')}</a>

                                                    <g:link class="button icon log" controller="inventoryLevel" action="export" id="${productInstance?.id}">
                                                        ${warehouse.message(code:'inventoryLevel.export.label', default: 'Export stock levels')}
                                                    </g:link>

                                                    <g:if test="${productInstance?.id }">
                                                        <g:link controller='inventoryItem' action='showStockCard' id='${productInstance?.id }' class="button icon remove">
                                                            ${warehouse.message(code: 'default.button.cancel.label', default: 'Cancel')}
                                                        </g:link>
                                                    </g:if>
                                                    <g:else>
                                                        <g:link controller="inventory" action="browse" class="button icon remove">
                                                            ${warehouse.message(code: 'default.button.cancel.label', default: 'Cancel')}
                                                        </g:link>
                                                    </g:else>

                                                </td>
                                            </tr>
                                        </tfoot>
                                    </table>
                                </div>
							</g:form>
						</div>

						<div id="tabs-documents" style="padding: 10px;" class="ui-tabs-hide">

                            <div class="box">
                                <h2>
                                    <warehouse:message code="product.documents.label" default="Product documents"/>
                                </h2>
                                <!-- process an upload or save depending on whether we are adding a new doc or modifying a previous one -->
                                <g:uploadForm controller="product" action="upload">
                                    <g:hiddenField name="product.id" value="${productInstance?.id}" />
                                    <g:hiddenField name="document.id" value="${documentInstance?.id}" />
                                    <table>
                                        <tr class="prop">
                                            <td class="name"><label><warehouse:message
                                                code="document.selectUrl.label" default="Select URL" /></label>
                                            </td>
                                            <td class="value">
                                                <g:textField name="url" value="${params.url }" placeholder="http://www.example.com/images/image.gif" class="text medium" size="80"/>
                                                &nbsp;
                                                <!-- show upload or save depending on whether we are adding a new doc or modifying a previous one -->
                                                <button type="submit" class="button icon approve">
                                                    ${documentInstance?.id ? warehouse.message(code:'default.button.save.label') : warehouse.message(code:'default.button.upload.label')}</button>
                                            </td>
                                        </tr>
                                        <tr class="prop">
                                            <td class="name"><label><warehouse:message
                                                code="document.selectFile.label" /></label>
                                            </td>
                                            <td class="value">
                                                <input name="fileContents" type="file" />
                                                &nbsp;
                                                <!-- show upload or save depending on whether we are adding a new doc or modifying a previous one -->
                                                <button type="submit" class="button icon approve">
                                                    ${documentInstance?.id ? warehouse.message(code:'default.button.save.label') : warehouse.message(code:'default.button.upload.label')}</button>
                                            </td>
                                        </tr>
                                        <tr class="prop">
                                            <td class="name"><label for="documents"><warehouse:message
                                                        code="documents.label" /></label></td>
                                            <td
                                                class="value">

                                                <table id="documents" class="box">
                                                    <thead>
                                                        <tr>
                                                            <th>
                                                                <!-- Delete -->
                                                            </th>
                                                            <th>
                                                                <warehouse:message code="document.filename.label"/>
                                                            </th>
                                                            <th>
                                                                <warehouse:message code="document.contentType.label"/>
                                                            </th>
                                                            <th>
                                                                <warehouse:message code="default.dateCreated.label"/>
                                                            </th>
                                                            <th>
                                                                <warehouse:message code="default.lastUpdated.label"/>
                                                            </th>
                                                            <th>
                                                            </th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <g:each var="document" in="${productInstance?.documents }" status="i">
                                                            <tr class="prop ${i%2?'even':'odd' }" >
                                                                <td>
                                                                   <g:link controller="product" action="downloadDocument" id="${document?.id}" params="['product.id':productInstance?.id]" target="_blank">
                                                                        <img src="${createLink(controller:'product', action:'viewThumbnail', id:document.id)}"
                                                                             class="middle" style="padding: 2px; margin: 2px; border: 1px solid lightgrey;" />
                                                                   </g:link>
                                                                </td>
                                                                <td>
                                                                    <g:link controller="product" action="downloadDocument" id="${document?.id}" params="['product.id':productInstance?.id]" target="_blank">
                                                                        ${document.filename }
                                                                    </g:link>
                                                                </td>
                                                                <td>
                                                                    ${document.contentType }
                                                                </td>
                                                                <td>
                                                                    ${document.dateCreated }
                                                                </td>
                                                                <td>
                                                                    ${document.lastUpdated }
                                                                </td>
                                                                <td>
                                                                    <%--
                                                                    <g:link controller="document" action="edit" id="${document?.id}" params="['product.id':productInstance?.id]">
                                                                        <img src="${createLinkTo(dir:'images/icons/silk',file:'pencil.png')}" alt="Edit" />
                                                                    </g:link>
                                                                    --%>
                                                                    <g:link controller="product" action="downloadDocument" id="${document?.id}" params="['product.id':productInstance?.id]" target="_blank">
                                                                        <img src="${createLinkTo(dir:'images/icons/silk',file:'zoom.png')}" alt="Download" />
                                                                    </g:link>
                                                                    <g:link controller="product" action="deleteDocument" id="${document?.id}" params="['product.id':productInstance?.id]" onclick="return confirm('${warehouse.message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');">
                                                                        <img src="${createLinkTo(dir:'images/icons/silk',file:'cross.png')}" alt="Delete" />
                                                                    </g:link>

                                                                </td>
                                                            </tr>
                                                        </g:each>
                                                        <g:unless test="${productInstance?.documents }">
                                                            <tr>
                                                                <td colspan="6">
                                                                    <div class="padded fade center">
                                                                        <warehouse:message code="product.hasNoDocuments.message"/>
                                                                    </div>
                                                                </td>
                                                            </tr>
                                                        </g:unless>
                                                    </tbody>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                </g:uploadForm>
                            </div>
						</div>


						<div id="tabs-packages" style="padding: 10px;" class="ui-tabs-hide">
				            <%-- <g:if test="${flash.message}">
				            	<div class="message">${flash.message}</div>
				            </g:if>

				            <g:hasErrors bean="${inventoryLevelInstance}">
					            <div class="errors">
					                <g:renderErrors bean="${inventoryLevelInstance}" as="list" />
					            </div>
				            </g:hasErrors>
							--%>


							<div class="box">
                                <h2>
                                    <warehouse:message code="product.packages.label" default="Product packages"/>
                                </h2>
								<table>
									<thead>
										<tr>
											<th>
												<warehouse:message code="package.name.label"/>
											</th>
											<th>
												<warehouse:message code="package.uom.label"/>
											</th>
											<th>
												<warehouse:message code="package.description.label"/>
											</th>
                                            <th>
                                                <warehouse:message code="package.price.label"/>
                                            </th>
											<th>
												<warehouse:message code="package.gtin.label"/>
											</th>
                                            <th>
                                                <warehouse:message code="default.actions.label"/>
                                            </th>
										</tr>
									</thead>
									<tbody>
										<g:each var="pkg" in="${productInstance.packages }" status="status">
											<tr class="${status%2?'even':'odd'}">
												<td>
													${pkg?.name }
												</td>
												<td>
													${pkg?.uom?.name }
												</td>
												<td>
													${pkg?.uom?.code }/${pkg?.quantity }
												</td>
                                                <td>
                                                    <g:formatNumber number="${pkg?.price}" />
                                                    ${grailsApplication.config.openboxes.locale.defaultCurrencyCode}

                                                </td>
												<td>
													${pkg?.gtin?:warehouse.message(code:'default.none.label') }
												</td>
                                                <td>
                                                    <a href="javascript:void(0);" dialog-id="editProductPackage-${pkg?.id }" class="open-dialog button icon edit">
                                                        <warehouse:message code="default.edit.label" args="[warehouse.message(code:'package.label')]"/>
                                                    </a>
                                                    <g:link controller="product" action="removePackage" id="${pkg.id }" params="['product.id':productInstance.id]" class="button icon trash">
                                                        <warehouse:message code="default.delete.label" args="[warehouse.message(code:'package.label')]"/>
                                                    </g:link>
                                                </td>

                                        </tr>
										</g:each>
										<g:unless test="${productInstance?.packages }">
											<tr>
												<td colspan="6">
                                                    <div class="empty center">
    													<warehouse:message code="package.packageNotFound.message"/>
                                                    </div>
												</td>
											</tr>
										</g:unless>

									</tbody>
                                    <tfoot>
                                        <tr>
                                            <td colspan="6">
                                                <div class="center">
                                                    <span class="">
                                                        <a href="javascript:void(0);" class="open-dialog create button primary" dialog-id="createProductPackage"><warehouse:message code="package.add.label"/></a>
                                                    </span>
                                                    <span class="">
                                                        <a href="javascript:void(0);" class="open-dialog create button" dialog-id="uom-dialog">Add UoM</a>
                                                    </span>
                                                    <span class="">
                                                        <a href="javascript:void(0);" class="open-dialog create button" dialog-id="uom-class-dialog">Add UoM Class</a>
                                                    </span>
                                                </div>
                                            </td>
                                        </tr>

                                    </tfoot>
								</table>

							</div>
						</div>
                        <div id="inventory-level-dialog" class="dialog hidden" title="Add a new stock level">
                            <g:render template="../inventoryLevel/form" model="[productInstance:productInstance,inventoryLevelInstance:new InventoryLevel()]"/>
                        </div>
                        <div id="uom-class-dialog" class="dialog hidden" title="Add a unit of measure class">
							<g:form controller="unitOfMeasureClass" action="save" method="post">
								<table>
		                            <tr class="prop">
		                                <td class="name">
		                                    <label for="name">Name</label>
		                                </td>
		                                <td class="value ">
											<g:textField name="name" size="10" class="medium text" />
		                                </td>
		                            </tr>
		                            <tr class="prop">
		                                <td class="name">
		                                    <label for="code">Type</label>
		                                </td>
		                                <td class="value ">
											<g:select name="type" from="${org.pih.warehouse.core.UnitOfMeasureType.list() }" value="${packageInstance?.uom }" noSelection="['null':'']"></g:select>
		                                    <span class="fade"></span>
		                                </td>
		                            </tr>

		                            <tr class="prop">
		                                <td class="name">
		                                    <label for="code">Code</label>
		                                </td>
		                                <td class="value ">
		                                    <g:textField name="code" size="10" class="medium text" />
		                                    <span class="fade"></span>
		                                </td>
		                            </tr>
									<tr class="prop">
		                                <td class="name">
		                                    <label for="name">Name</label>
		                                </td>
		                                <td class="value ">
		                                    <g:textField name="name" size="40" class="medium text" />
		                                    <span class="fade"></span>
		                                </td>
		                            </tr>

	                            </table>
								<div class="buttons">
				                   <input type="submit" name="create" class="save" value="Create" id="create" />
				                   <a href="#" class="close-dialog" dialog-id="uom-class-dialog">${warehouse.message(code: 'default.button.cancel.label', default: 'Cancel')}</a>
				                </div>



							</g:form>
						</div>

						<div id="uom-dialog" class="dialog hidden" title="Add a unit of measure">

							<g:form controller="unitOfMeasure" action="save" method="post">
								<table>
		                            <tr class="prop">
		                                <td class="name">
		                                    <label for="uomClass.id">Uom Class</label>
		                                </td>
		                                <td class="value ">
											<g:select name="uomClass.id" from="${org.pih.warehouse.core.UnitOfMeasureClass.list() }" optionValue="name" optionKey="id" value="${pacakageInstance?.uom }" noSelection="['null':'']"></g:select>
											<span class="linkButton">
												<a href="javascript:void(0);" class="open-dialog create" dialog-id="uom-class-dialog">Add UoM Class</a>
											</span>
		                                </td>
		                            </tr>
		                            <tr class="prop">
		                                <td class="name">
		                                    <label for="code">Code</label>
		                                </td>
		                                <td class="value ">
		                                    <g:textField name="code" size="10" class="medium text" />
		                                </td>
		                            </tr>
									<tr class="prop">
		                                <td class="name">
		                                    <label for="name">Name</label>
		                                </td>
		                                <td class="value ">
		                                    <g:textField name="name" size="40" class="medium text" />
		                                </td>
		                            </tr>

		                            <tr class="prop">
		                                <td class="name">
		                                    <label for="description">Description</label>
		                                </td>
		                                <td class="value ">
											<g:textField name="description" size="40" class="medium text" />
		                                </td>
		                            </tr>

		                      	</table>

								<div class="buttons">
				                   <input type="submit" name="create" class="save" value="Create" id="create" />
				                   <a href="#" class="close-dialog" dialog-id="uom-dialog">${warehouse.message(code: 'default.button.cancel.label', default: 'Cancel')}</a>
				                </div>
		                	</g:form>
						</div>

						<g:render template="productPackageDialog" model="[dialogId:'createProductPackage',productInstance:productInstance,packageInstance:packageInstance]"/>
					</g:if>
				</div>	
			</div>
		</div>

        <g:each var="inventoryLevelInstance" in="${productInstance?.inventoryLevels}" status="i">
            <div id="inventory-level-${inventoryLevelInstance?.id}-dialog" class="dialog hidden" title="Edit inventory level">
                <g:render template="../inventoryLevel/form" model="[inventoryLevelInstance:inventoryLevelInstance]"/>
            </div>
        </g:each>
        <g:each var="packageInstance" in="${productInstance.packages }">
            <g:set var="dialogId" value="${'editProductPackage-' + packageInstance.id}"/>
            <g:render template="productPackageDialog" model="[dialogId:dialogId,productInstance:productInstance,packageInstance:packageInstance]"/>
        </g:each>



    <%--
        <g:render template='category' model="['category':null,'i':'_clone','hidden':true]"/>
    --%>
		<script type="text/javascript">


            function updateSynonymTable(data) {
                console.log("updateSynonymTable");
                console.log(data);
            }


	    	$(document).ready(function() {
		    	$(".tabs").tabs(
	    			{
	    				cookie: {
	    					// store cookie for a day, without, it would be a session cookie
	    					expires: 1
	    				}
	    			}
				); 

				$(".dialog").dialog({ autoOpen: false, modal: true, width: '800px'});

				$(".open-dialog").click(function() { 
					var id = $(this).attr("dialog-id");
					$("#"+id).dialog('open');
				});
				$(".close-dialog").click(function() { 
					var id = $(this).attr("dialog-id");
					$("#"+id).dialog('close');
				});

				$(".attributeValueSelector").change(function(event) {
					if ($(this).val() == '_other') {
						$(this).parent().find(".otherAttributeValue").show();
					}
					else {
						$(this).parent().find(".otherAttributeValue").val('').hide();
					}
				});

				function updateBinLocation() { 
					$("#binLocation").val('updated')
				}

				$(".binLocation").change(function(){ updateBinLocation() });
				
			});
		</script>
    </body>
</html>
