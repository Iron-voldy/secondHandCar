<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<header>
    <div style="display: flex; justify-content: space-between; align-items: center; padding: 0 20px;">
        <h1>
            <i class="fas fa-car"></i>
            Second-Hand Car Sales
        </h1>
        <nav>
            <a href="<%=request.getContextPath()%>/"><i class="fas fa-home"></i> Home</a>
            <a href="<%=request.getContextPath()%>/cars"><i class="fas fa-search"></i> Browse Cars</a>
            <a href="<%=request.getContextPath()%>/reviews"><i class="fas fa-star"></i> Reviews</a>
            <a href="<%=request.getContextPath()%>/cars/add"><i class="fas fa-plus-circle"></i> Sell a Car</a>
        </nav>
    </div>
</header>