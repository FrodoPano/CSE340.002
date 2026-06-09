import { addVolunteer, removeVolunteer, getUserVolunteerProjects } from '../models/volunteers.js';

const signUpForProject = async (req, res) => {
    const projectId = req.params.projectId;
    const userId = req.session.user.user_id;
    
    try {
        await addVolunteer(userId, projectId);
        req.flash('success', 'You have signed up to volunteer for this project!');
    } catch (error) {
        console.error('Error signing up for project:', error);
        req.flash('error', 'You are already signed up for this project.');
    }
    
    res.redirect(`/project/${projectId}`);
};

const removeSignUpFromProject = async (req, res) => {
    const projectId = req.params.projectId;
    const userId = req.session.user.user_id;
    
    try {
        await removeVolunteer(userId, projectId);
        req.flash('success', 'You have been removed as a volunteer for this project.');
    } catch (error) {
        console.error('Error removing volunteer signup:', error);
        req.flash('error', 'An error occurred while removing your signup.');
    }
    
    res.redirect(`/project/${projectId}`);
};

const removeSignUpFromDashboard = async (req, res) => {
    const projectId = req.params.projectId;
    const userId = req.session.user.user_id;
    
    try {
        await removeVolunteer(userId, projectId);
        req.flash('success', 'You have been removed as a volunteer for this project.');
    } catch (error) {
        console.error('Error removing volunteer signup:', error);
        req.flash('error', 'An error occurred while removing your signup.');
    }
    
    res.redirect('/dashboard');
};

export { signUpForProject, removeSignUpFromProject, removeSignUpFromDashboard };