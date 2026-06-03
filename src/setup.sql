
-- ========================================
-- Organization Table
-- ========================================
CREATE TABLE organization (
    organization_id SERIAL PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    description TEXT NOT NULL,
    contact_email VARCHAR(255) NOT NULL,
    logo_filename VARCHAR(255) NOT NULL
);


-- ========================================
-- Insert sample data: Organizations
-- ========================================
INSERT INTO organization (name, description, contact_email, logo_filename)
VALUES
('BrightFuture Builders', 'A nonprofit focused on improving community infrastructure through sustainable construction projects.', 'info@brightfuturebuilders.org', 'brightfuture-logo.png'),
('GreenHarvest Growers', 'An urban farming collective promoting food sustainability and education in local neighborhoods.', 'contact@greenharvest.org', 'greenharvest-logo.png'),
('UnityServe Volunteers', 'A volunteer coordination group supporting local charities and service initiatives.', 'hello@unityserve.org', 'unityserve-logo.png');

-- ========================================
-- Service Project Table
-- ========================================
CREATE TABLE service_project (
    project_id SERIAL PRIMARY KEY,
    organization_id INTEGER NOT NULL,
    title VARCHAR(200) NOT NULL,
    description TEXT NOT NULL,
    location VARCHAR(255) NOT NULL,
    date DATE NOT NULL,
    CONSTRAINT fk_organization
        FOREIGN KEY (organization_id) 
        REFERENCES organization(organization_id)
        ON DELETE CASCADE
);

-- ========================================
-- Insert sample data: Service Projects
-- ========================================

-- Projects for BrightFuture Builders (organization_id = 1)
INSERT INTO service_project (organization_id, title, description, location, date) VALUES
(1, 'Community Playground Renovation', 'Volunteers will repair and repaint playground equipment, install new safety surfacing, and add accessible swings for children with disabilities.', 'Oakwood Community Park, 4500 Parkview Drive', '2026-06-15'),
(1, 'Senior Center Accessibility Ramp', 'Building wheelchair ramps and handrails for the downtown senior community center to improve accessibility for elderly residents.', 'Downtown Senior Center, 215 Elder Street', '2026-07-22'),
(1, 'Neighborhood Sidewalk Repair', 'Fixing cracked and uneven sidewalks in the Westside neighborhood to improve pedestrian safety and walkability.', 'Westside Neighborhood, Main Street Corridor', '2026-08-10'),
(1, 'School Garden Shed Construction', 'Constructing a storage shed and greenhouse for the Lincoln Elementary School garden program to support student agricultural education.', 'Lincoln Elementary School, 890 Education Lane', '2026-09-05'),
(1, 'Habitat Home Build Day', 'Partnering with Habitat for Humanity to frame and roof a new affordable home for a local family in need.', '123 Hope Avenue, Riverside District', '2026-10-12');

-- Projects for GreenHarvest Growers (organization_id = 2)
INSERT INTO service_project (organization_id, title, description, location, date) VALUES
(2, 'Spring Community Garden Planting', 'Annual spring planting event where volunteers help prepare soil beds, plant vegetables, and set up irrigation systems for the community garden.', 'Sunrise Community Garden, 780 Green Valley Road', '2026-04-20'),
(2, 'Farmers Market Setup and Support', 'Assisting with the weekly farmers market setup, including vendor booth arrangement, signage placement, and customer information booth.', 'Downtown Plaza, 150 Market Square', '2026-05-30'),
(2, 'Food Bank Harvest Collection', 'Organizing a neighborhood harvest collection drive to gather fresh produce from local gardens for donation to the city food bank.', 'Various Locations - Central Collection at 340 Harvest Lane', '2026-07-15'),
(2, 'Urban Farming Workshop Series', 'Leading educational workshops on container gardening, composting, and sustainable growing practices for apartment residents.', 'GreenHarvest Education Center, 567 Grow Street', '2026-08-25'),
(2, 'School Nutrition Garden Installation', 'Installing raised garden beds and teaching students about growing their own food at Jefferson Middle School.', 'Jefferson Middle School, 234 Education Boulevard', '2026-09-18');

-- Projects for UnityServe Volunteers (organization_id = 3)
INSERT INTO service_project (organization_id, title, description, location, date) VALUES
(3, 'Annual River Cleanup Day', 'Mobilizing 200+ volunteers to remove trash and debris from the Riverside Park area and adjacent waterways.', 'Riverside Park, 890 River Road', '2026-05-10'),
(3, 'Homeless Shelter Meal Service', 'Preparing and serving hot meals at the Hope Haven homeless shelter, with volunteers working in shifts throughout the day.', 'Hope Haven Shelter, 412 Compassion Way', '2026-06-28'),
(3, 'Back-to-School Supply Drive', 'Collecting, sorting, and distributing backpacks and school supplies to underprivileged students in the community.', 'UnityServe Community Center, 123 Volunteer Avenue', '2026-08-05'),
(3, 'Senior Tech Literacy Program', 'Teaching basic computer and smartphone skills to senior citizens at the local library to help them stay connected with family.', 'City Public Library, 789 Knowledge Parkway', '2026-09-22'),
(3, 'Emergency Preparedness Fair', 'Organizing a community fair to educate residents about emergency preparedness, including first aid demonstrations and disaster kit assembly.', 'Civic Center Auditorium, 321 Government Plaza', '2026-10-30');

-- ========================================
-- Verify data insertion
-- ========================================
SELECT * FROM service_project;

-- ========================================
-- Category Table
-- ========================================
CREATE TABLE category (
    category_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

-- ========================================
-- Project-Category Junction Table
-- ========================================
CREATE TABLE project_category (
    project_id INTEGER NOT NULL,
    category_id INTEGER NOT NULL,
    PRIMARY KEY (project_id, category_id),
    CONSTRAINT fk_project
        FOREIGN KEY (project_id) 
        REFERENCES service_project(project_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_category
        FOREIGN KEY (category_id) 
        REFERENCES category(category_id)
        ON DELETE CASCADE
);

-- ========================================
-- Insert sample data: Categories
-- ========================================
INSERT INTO category (name) VALUES
('Environmental'),
('Education'),
('Community Development'),
('Health & Wellness'),
('Youth Services');

-- ========================================
-- Insert sample data: Project-Category Associations
-- ========================================

-- BrightFuture Builders projects (organization_id = 1)
-- Community Playground Renovation (project_id = 1)
INSERT INTO project_category (project_id, category_id) VALUES
(1, (SELECT category_id FROM category WHERE name = 'Community Development')),
(1, (SELECT category_id FROM category WHERE name = 'Youth Services'));

-- Senior Center Accessibility Ramp (project_id = 2)
INSERT INTO project_category (project_id, category_id) VALUES
(2, (SELECT category_id FROM category WHERE name = 'Community Development')),
(2, (SELECT category_id FROM category WHERE name = 'Health & Wellness'));

-- Neighborhood Sidewalk Repair (project_id = 3)
INSERT INTO project_category (project_id, category_id) VALUES
(3, (SELECT category_id FROM category WHERE name = 'Community Development'));

-- School Garden Shed Construction (project_id = 4)
INSERT INTO project_category (project_id, category_id) VALUES
(4, (SELECT category_id FROM category WHERE name = 'Education')),
(4, (SELECT category_id FROM category WHERE name = 'Youth Services'));

-- Habitat Home Build Day (project_id = 5)
INSERT INTO project_category (project_id, category_id) VALUES
(5, (SELECT category_id FROM category WHERE name = 'Community Development'));

-- GreenHarvest Growers projects (organization_id = 2)
-- Spring Community Garden Planting (project_id = 6)
INSERT INTO project_category (project_id, category_id) VALUES
(6, (SELECT category_id FROM category WHERE name = 'Environmental')),
(6, (SELECT category_id FROM category WHERE name = 'Community Development'));

-- Farmers Market Setup and Support (project_id = 7)
INSERT INTO project_category (project_id, category_id) VALUES
(7, (SELECT category_id FROM category WHERE name = 'Community Development')),
(7, (SELECT category_id FROM category WHERE name = 'Health & Wellness'));

-- Food Bank Harvest Collection (project_id = 8)
INSERT INTO project_category (project_id, category_id) VALUES
(8, (SELECT category_id FROM category WHERE name = 'Community Development')),
(8, (SELECT category_id FROM category WHERE name = 'Health & Wellness'));

-- Urban Farming Workshop Series (project_id = 9)
INSERT INTO project_category (project_id, category_id) VALUES
(9, (SELECT category_id FROM category WHERE name = 'Education')),
(9, (SELECT category_id FROM category WHERE name = 'Environmental'));

-- School Nutrition Garden Installation (project_id = 10)
INSERT INTO project_category (project_id, category_id) VALUES
(10, (SELECT category_id FROM category WHERE name = 'Education')),
(10, (SELECT category_id FROM category WHERE name = 'Environmental')),
(10, (SELECT category_id FROM category WHERE name = 'Youth Services'));

-- UnityServe Volunteers projects (organization_id = 3)
-- Annual River Cleanup Day (project_id = 11)
INSERT INTO project_category (project_id, category_id) VALUES
(11, (SELECT category_id FROM category WHERE name = 'Environmental')),
(11, (SELECT category_id FROM category WHERE name = 'Community Development'));

-- Homeless Shelter Meal Service (project_id = 12)
INSERT INTO project_category (project_id, category_id) VALUES
(12, (SELECT category_id FROM category WHERE name = 'Community Development')),
(12, (SELECT category_id FROM category WHERE name = 'Health & Wellness'));

-- Back-to-School Supply Drive (project_id = 13)
INSERT INTO project_category (project_id, category_id) VALUES
(13, (SELECT category_id FROM category WHERE name = 'Education')),
(13, (SELECT category_id FROM category WHERE name = 'Youth Services'));

-- Senior Tech Literacy Program (project_id = 14)
INSERT INTO project_category (project_id, category_id) VALUES
(14, (SELECT category_id FROM category WHERE name = 'Education')),
(14, (SELECT category_id FROM category WHERE name = 'Community Development'));

-- Emergency Preparedness Fair (project_id = 15)
INSERT INTO project_category (project_id, category_id) VALUES
(15, (SELECT category_id FROM category WHERE name = 'Community Development')),
(15, (SELECT category_id FROM category WHERE name = 'Health & Wellness'));

-- ========================================
-- Verify category data insertion
-- ========================================
SELECT 
    sp.title AS project_title,
    c.name AS category_name
FROM service_project sp
JOIN project_category pc ON sp.project_id = pc.project_id
JOIN category c ON pc.category_id = c.category_id
ORDER BY sp.title, c.name;


-- ========================================
-- Roles table
-- ========================================

CREATE TABLE roles (
    role_id SERIAL PRIMARY KEY,
    role_name VARCHAR(50) UNIQUE NOT NULL,
    role_description TEXT
);


INSERT INTO roles (role_name, role_description) VALUES 
    ('user', 'Standard user with basic access'),
    ('admin', 'Administrator with full system access');

-- Verify the data was inserted
SELECT * FROM roles;

CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    role_id INTEGER REFERENCES roles(role_id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ========================================
-- Roles test
-- ========================================

-- Insert a test user
INSERT INTO users (name, email, password_hash, role_id) 
VALUES ('testuser', 'test@example.com', 'placeholder_hash', 1);

-- Join users and roles to see complete information
SELECT u.user_id, u.name, u.email, r.role_name, r.role_description
FROM users u
JOIN roles r ON u.role_id = r.role_id;

-- Delete the test user
DELETE FROM users WHERE email = 'test@example.com';

-- ========================================
-- Admin
-- ========================================

-- Update the admin account to have admin role
UPDATE users SET role_id = (SELECT role_id FROM roles WHERE role_name = 'admin') WHERE email = 'admin@example.com';

-- Verify the update
SELECT users.user_id, users.email, roles.role_name 
FROM users 
JOIN roles ON users.role_id = roles.role_id;