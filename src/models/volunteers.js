import db from './db.js'

const addVolunteer = async (userId, projectId) => {
    const query = `
        INSERT INTO volunteer_signup (user_id, project_id)
        VALUES ($1, $2)
        RETURNING signup_id;
    `;
    
    const queryParams = [userId, projectId];
    const result = await db.query(query, queryParams);
    
    if (result.rows.length === 0) {
        throw new Error('Failed to add volunteer signup');
    }
    
    return result.rows[0].signup_id;
};

const removeVolunteer = async (userId, projectId) => {
    const query = `
        DELETE FROM volunteer_signup
        WHERE user_id = $1 AND project_id = $2
        RETURNING signup_id;
    `;
    
    const queryParams = [userId, projectId];
    const result = await db.query(query, queryParams);
    
    return result.rows.length > 0;
};

const getUserVolunteerProjects = async (userId) => {
    const query = `
        SELECT 
            sp.project_id,
            sp.title,
            sp.description,
            sp.date,
            sp.location,
            o.name as organization_name,
            vs.signup_date
        FROM volunteer_signup vs
        JOIN service_project sp ON vs.project_id = sp.project_id
        JOIN organization o ON sp.organization_id = o.organization_id
        WHERE vs.user_id = $1
        ORDER BY sp.date;
    `;
    
    const queryParams = [userId];
    const result = await db.query(query, queryParams);
    
    return result.rows;
};

const isUserVolunteer = async (userId, projectId) => {
    const query = `
        SELECT signup_id
        FROM volunteer_signup
        WHERE user_id = $1 AND project_id = $2;
    `;
    
    const queryParams = [userId, projectId];
    const result = await db.query(query, queryParams);
    
    return result.rows.length > 0;
};

export { addVolunteer, removeVolunteer, getUserVolunteerProjects, isUserVolunteer };