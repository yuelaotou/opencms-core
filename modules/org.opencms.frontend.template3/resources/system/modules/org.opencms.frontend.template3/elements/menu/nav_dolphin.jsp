<%@page session="false" import="org.opencms.frontend.template3.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%><%

    // This element defines the a top level navigation element which can be
	// selected in the style configuration file.
	//
	// Single navigation enties of the first navigation level are shown as
	// highlighted tabs.
	//
	// It uses the CmsTemplateMenu class to provide some auxiliary methods
	// in order to prevent the use of scriplet code in this jsp.
	// For details on the CmsTemplateMenu class, see the source code which can
	// be found at the following VFS location:
	// /system/modules/org.opencms.frontend.template3/java_src/CmsTemplateMenu.java

	CmsTemplateMenu cms = new CmsTemplateMenu(pageContext, request, response);
	cms.setElements(cms.getNavigation().getNavigationForFolder("/"));
	pageContext.setAttribute("cms", cms);
%>

<div id="nav_main">
	<div id="dolphincontainer">
		<div id="dolphinnav">
			<ul>
				<c:set var="oldLevel" value="" />
				<c:forEach items="${cms.elements}" var="elem">
					<c:set var="currentLevel" value="${elem.navTreeLevel}" />
					
					<c:choose>
						<c:when test="${empty oldLevel}"></c:when>
						<c:when test="${currentLevel > oldLevel}"><ul></c:when>
						<c:when test="${currentLevel == oldLevel}"></li></c:when>
						<c:when test="${oldLevel > currentLevel}">
							<c:forEach begin="${currentLevel+1}" end="${oldLevel}"></li></ul></c:forEach>
						</c:when>
					</c:choose>
					
					<li>
					<a href="<cms:link>${elem.resourceName}</cms:link>" <c:if test="${fn:startsWith(cms.requestContext.uri, elem.resourceName)}">class="current"</c:if>><span>${elem.navText}</span></a>
					
					<c:set var="oldLevel" value="${currentLevel}" />
				</c:forEach>
				
				<c:forEach begin="${cms.topLevel+1}" end="${oldLevel}"></li></ul></c:forEach>
			</ul>
		</div>
	</div>
</div>