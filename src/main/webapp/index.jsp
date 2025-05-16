<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Second-Hand Car Sales Platform</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/styles.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <style>
        .hero {
            background: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)), url('<%=request.getContextPath()%>/images/cars/hero.jpg') no-repeat center center;
            background-size: cover;
            height: 600px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            text-align: center;
        }

        .hero-content {
            max-width: 800px;
            padding: 0 20px;
        }

        .hero h1 {
            font-size: 3rem;
            margin-bottom: 20px;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);
        }

        .hero p {
            font-size: 1.2rem;
            margin-bottom: 30px;
            text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.5);
        }

        .hero-buttons {
            display: flex;
            justify-content: center;
            gap: 20px;
        }

        .hero-btn {
            padding: 15px 30px;
            font-size: 1.1rem;
            border-radius: 30px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .feature-section {
            padding: 80px 0;
        }

        .features {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
            margin-top: 40px;
        }

        .feature {
            flex: 1 1 300px;
            text-align: center;
            padding: 30px;
            margin: 15px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            transition: transform 0.3s ease;
        }

        .feature:hover {
            transform: translateY(-10px);
        }

        .feature i {
            font-size: 48px;
            color: #1e3c72;
            margin-bottom: 20px;
        }

        .feature h3 {
            margin-bottom: 15px;
            color: #333;
        }

        .feature p {
            color: #666;
            line-height: 1.6;
        }

        @media (max-width: 768px) {
            .hero h1 {
                font-size: 2.5rem;
            }

            .hero-buttons {
                flex-direction: column;
                gap: 10px;
            }

            .feature {
                flex: 1 1 100%;
            }
        }
    </style>
</head>
<body>
<%@ include file="includes/header.jsp" %>

<!-- Hero Section -->
<section class="hero">
    <div class="hero-content">
        <h1>Find Your Perfect Car</h1>
        <p>Browse our extensive collection of quality second-hand cars at competitive prices. Whether you're looking for a family vehicle, a sporty ride, or a reliable commuter, we've got you covered.</p>
        <div class="hero-buttons">
            <a href="<%=request.getContextPath()%>/cars" class="btn btn-primary hero-btn">
                <i class="fas fa-search"></i> Browse Cars
            </a>
            <a href="<%=request.getContextPath()%>/cars/add" class="btn btn-secondary hero-btn">
                <i class="fas fa-plus"></i> Sell Your Car
            </a>
        </div>
    </div>
</section>

<!-- Features Section -->
<section class="feature-section">
    <div class="container">
        <h2 style="text-align: center; margin-bottom: 20px;">Why Choose Our Platform?</h2>
        <div class="features">
            <div class="feature">
                <i class="fas fa-car"></i>
                <h3>Quality Vehicles</h3>
                <p>All cars on our platform undergo a thorough quality check to ensure they meet our high standards before being listed.</p>
            </div>
            <div class="feature">
                <i class="fas fa-dollar-sign"></i>
                <h3>Competitive Prices</h3>
                <p>Find the best deals on used cars with our transparent pricing system and no hidden fees.</p>
            </div>
            <div class="feature">
                <i class="fas fa-shield-alt"></i>
                <h3>Secure Transactions</h3>
                <p>Our secure platform ensures that all transactions are safe and protected for both buyers and sellers.</p>
            </div>
        </div>
        <div class="features">
            <div class="feature">
                <i class="fas fa-handshake"></i>
                <h3>Direct Communication</h3>
                <p>Connect directly with sellers to ask questions and arrange viewings without intermediaries.</p>
            </div>
            <div class="feature">
                <i class="fas fa-search"></i>
                <h3>Advanced Search</h3>
                <p>Find your dream car quickly with our powerful search and filtering options.</p>
            </div>
            <div class="feature">
                <i class="fas fa-mobile-alt"></i>
                <h3>Mobile Friendly</h3>
                <p>Browse and manage listings on any device, anytime, anywhere.</p>
            </div>
        </div>
    </div>
</section>

<!-- Reviews Section -->
<section style="background-color: #f0f4ff; padding: 80px 0; text-align: center;">
    <div class="container">
        <h2>Customer Reviews</h2>
        <p style="margin: 20px 0 30px; max-width: 600px; margin-left: auto; margin-right: auto;">
            See what our customers have to say about their experiences with our cars.
            Your feedback helps others make better buying decisions.
        </p>

        <div style="display: flex; flex-wrap: wrap; gap: 20px; justify-content: center; margin: 30px 0;">
            <div style="flex: 1; min-width: 300px; max-width: 400px; background-color: white; border-radius: 8px; padding: 25px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); text-align: left;">
                <div style="margin-bottom: 15px;">
                    <i class="fas fa-star" style="color: #FFD700;"></i>
                    <i class="fas fa-star" style="color: #FFD700;"></i>
                    <i class="fas fa-star" style="color: #FFD700;"></i>
                    <i class="fas fa-star" style="color: #FFD700;"></i>
                    <i class="fas fa-star" style="color: #FFD700;"></i>
                </div>
                <p style="font-style: italic; color: #555; margin-bottom: 15px;">
                    "The car I purchased was exactly as described. Great condition, fair price, and the transaction was smooth and easy. Highly recommend this platform!"
                </p>
                <div style="display: flex; align-items: center;">
                    <div style="width: 40px; height: 40px; background-color: #1e3c72; color: white; border-radius: 50%; display: flex; align-items: center; justify-content: center; margin-right: 10px;">
                        <i class="fas fa-user"></i>
                    </div>
                    <div>
                        <div style="font-weight: 600;">Sarah Johnson</div>
                        <div style="font-size: 0.9em; color: #777;">Toyota Corolla Owner</div>
                    </div>
                </div>
            </div>

            <div style="flex: 1; min-width: 300px; max-width: 400px; background-color: white; border-radius: 8px; padding: 25px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); text-align: left;">
                <div style="margin-bottom: 15px;">
                    <i class="fas fa-star" style="color: #FFD700;"></i>
                    <i class="fas fa-star" style="color: #FFD700;"></i>
                    <i class="fas fa-star" style="color: #FFD700;"></i>
                    <i class="fas fa-star" style="color: #FFD700;"></i>
                    <i class="fas fa-star" style="color: #FFD700;"></i>
                </div>
                <p style="font-style: italic; color: #555; margin-bottom: 15px;">
                    "Found my dream car at an amazing price! The detailed descriptions and high-quality photos helped me make an informed decision. Couldn't be happier with my purchase."
                </p>
                <div style="display: flex; align-items: center;">
                    <div style="width: 40px; height: 40px; background-color: #1e3c72; color: white; border-radius: 50%; display: flex; align-items: center; justify-content: center; margin-right: 10px;">
                        <i class="fas fa-user"></i>
                    </div>
                    <div>
                        <div style="font-weight: 600;">Michael Brown</div>
                        <div style="font-size: 0.9em; color: #777;">Honda Civic Owner</div>
                    </div>
                </div>
            </div>
        </div>

        <div style="margin-top: 30px;">
            <a href="<%=request.getContextPath()%>/reviews" class="btn btn-primary hero-btn">
                <i class="fas fa-star"></i> See All Reviews
            </a>
        </div>
    </div>
</section>

<!-- Call to Action Section -->
<section style="background-color: #f9f9f9; padding: 80px 0; text-align: center;">
    <div class="container">
        <h2>Ready to Find Your Next Car?</h2>
        <p style="margin: 20px 0 30px; max-width: 600px; margin-left: auto; margin-right: auto;">Browse our collection of quality second-hand cars and find the perfect match for your needs and budget.</p>
        <a href="<%=request.getContextPath()%>/cars" class="btn btn-primary hero-btn">
            <i class="fas fa-car"></i> View All Cars
        </a>
    </div>
</section>

<%@ include file="includes/footer.jsp" %>
</body>
</html>