import express from 'express';

import { showHomePage } from './controllers/index.js';
import {
    showOrganizationsPage,
    showOrganizationDetailsPage,
    showNewOrganizationForm,
    processNewOrganizationForm,
    showEditOrganizationForm,
    processEditOrganizationForm,
    organizationValidation
} from './controllers/organizations.js';
import { showProjectsPage, showProjectDetailsPage, showNewProjectForm, processNewProjectForm, showEditProjectForm, processEditProjectForm, projectValidation } from './controllers/projects.js';
import { showCategoriesPage, showNewCategoryForm, processNewCategoryForm, showEditCategoryForm, processEditCategoryForm, categoryValidation } from './controllers/categories.js';
import { showCategoryDetailsPage } from './controllers/categoryDetails.js';
import { showAssignCategoriesForm, processAssignCategoriesForm } from './controllers/assignCategories.js';
import { showUserRegistrationForm, processUserRegistrationForm, showLoginForm, processLoginForm, processLogout, requireLogin, requireRole, showDashboard, showUsersPage } from './controllers/users.js';
import { signUpForProject, removeSignUpFromProject, removeSignUpFromDashboard } from './controllers/volunteers.js';
import { testErrorPage } from './controllers/errors.js';

const router = express.Router();

router.get('/', showHomePage);
router.get('/organizations', showOrganizationsPage);
router.get('/organization/:id', showOrganizationDetailsPage);

// Admin-only routes for organizations
router.get('/new-organization', requireRole('admin'), showNewOrganizationForm);
router.post('/new-organization', requireRole('admin'), organizationValidation, processNewOrganizationForm);
router.get('/edit-organization/:id', requireRole('admin'), showEditOrganizationForm);
router.post('/edit-organization/:id', requireRole('admin'), organizationValidation, processEditOrganizationForm);

router.get('/projects', showProjectsPage);
router.get('/project/:id', showProjectDetailsPage);

// Admin-only routes for projects
router.get('/new-project', requireRole('admin'), showNewProjectForm);
router.post('/new-project', requireRole('admin'), projectValidation, processNewProjectForm);
router.get('/edit-project/:id', requireRole('admin'), showEditProjectForm);
router.post('/edit-project/:id', requireRole('admin'), projectValidation, processEditProjectForm);

router.get('/categories', showCategoriesPage);
router.get('/category/:id', showCategoryDetailsPage);

// Admin-only routes for categories
router.get('/new-category', requireRole('admin'), showNewCategoryForm);
router.post('/new-category', requireRole('admin'), categoryValidation, processNewCategoryForm);
router.get('/edit-category/:id', requireRole('admin'), showEditCategoryForm);
router.post('/edit-category/:id', requireRole('admin'), categoryValidation, processEditCategoryForm);

// Admin-only route for assigning categories
router.get('/assign-categories/:projectId', requireRole('admin'), showAssignCategoriesForm);
router.post('/assign-categories/:projectId', requireRole('admin'), processAssignCategoriesForm);

// Volunteer signup routes (require login)
router.post('/project/:projectId/volunteer', requireLogin, signUpForProject);
router.post('/project/:projectId/remove-volunteer', requireLogin, removeSignUpFromProject);
router.post('/dashboard/remove-volunteer/:projectId', requireLogin, removeSignUpFromDashboard);

// User registration routes
router.get('/register', showUserRegistrationForm);
router.post('/register', processUserRegistrationForm);

// User login routes
router.get('/login', showLoginForm);
router.post('/login', processLoginForm);
router.get('/logout', processLogout);

// Protected dashboard route
router.get('/dashboard', requireLogin, showDashboard);

// Admin-only users page
router.get('/users', requireRole('admin'), showUsersPage);

// error-handling routes
router.get('/test-error', testErrorPage);

export default router;