<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<footer>
    <div style="display: flex; flex-wrap: wrap; justify-content: space-between; padding: 0 20px; max-width: 1200px; margin: 0 auto;">
        <div style="flex: 1; min-width: 200px; margin: 10px;">
            <h3>Second-Hand Car Sales</h3>
            <p>The trusted platform for buying and selling used vehicles.</p>
            <div style="margin-top: 15px;">
                <a href="#" style="color: white; margin-right: 15px;"><i class="fab fa-facebook-f"></i></a>
                <a href="#" style="color: white; margin-right: 15px;"><i class="fab fa-twitter"></i></a>
                <a href="#" style="color: white; margin-right: 15px;"><i class="fab fa-instagram"></i></a>
                <a href="#" style="color: white;"><i class="fab fa-linkedin-in"></i></a>
            </div>
        </div>

        <div style="flex: 1; min-width: 200px; margin: 10px;">
            <h3>Quick Links</h3>
            <ul style="list-style: none; padding: 0;">
                <li style="margin-bottom: 5px;"><a href="<%=request.getContextPath()%>/" style="color: white; text-decoration: none;">Home</a></li>
                <li style="margin-bottom: 5px;"><a href="<%=request.getContextPath()%>/cars" style="color: white; text-decoration: none;">Browse Cars</a></li>
                <li style="margin-bottom: 5px;"><a href="<%=request.getContextPath()%>/cars/add" style="color: white; text-decoration: none;">Sell a Car</a></li>
            </ul>
        </div>

        <div style="flex: 1; min-width: 200px; margin: 10px;">
            <h3>Contact Us</h3>
            <ul style="list-style: none; padding: 0;">
                <li style="margin-bottom: 5px;"><i class="fas fa-map-marker-alt"></i> 123 Car Street, Autoville</li>
                <li style="margin-bottom: 5px;"><i class="fas fa-phone"></i> +1 (555) 123-4567</li>
                <li style="margin-bottom: 5px;"><i class="fas fa-envelope"></i> info@carsales.com</li>
            </ul>
        </div>
    </div>

    <div style="text-align: center; padding-top: 20px; border-top: 1px solid rgba(255,255,255,0.1);">
        <p>© 2025 Second-Hand Car Sales Platform. All rights reserved.</p>
    </div>
</footer>