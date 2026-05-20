import db from './db.js'

const getAllCategories = async() => {
    const query = `
        SELECT category_id, name
        FROM public.category
        ORDER BY name;
    `;

    const result = await db.query(query);
    return result.rows;
}

const getCategoryDetails = async (categoryId) => {
    const query = `
        SELECT category_id, name
        FROM category
        WHERE category_id = $1;
    `;
    
    const queryParams = [categoryId];
    const result = await db.query(query, queryParams);
    
    return result.rows.length > 0 ? result.rows[0] : null;
};

const getProjectsByCategoryId = async (categoryId) => {
    const query = `
        SELECT 
            sp.project_id,
            sp.title,
            sp.description,
            sp.date,
            sp.location,
            sp.organization_id,
            o.name as organization_name
        FROM service_project sp
        JOIN project_category pc ON sp.project_id = pc.project_id
        JOIN organization o ON sp.organization_id = o.organization_id
        WHERE pc.category_id = $1
        ORDER BY sp.date;
    `;
    
    const queryParams = [categoryId];
    const result = await db.query(query, queryParams);
    
    return result.rows;
};

const getCategoriesByProjectId = async (projectId) => {
    const query = `
        SELECT 
            c.category_id,
            c.name
        FROM category c
        JOIN project_category pc ON c.category_id = pc.category_id
        WHERE pc.project_id = $1
        ORDER BY c.name;
    `;
    
    const queryParams = [projectId];
    const result = await db.query(query, queryParams);
    
    return result.rows;
};

export { getAllCategories, getCategoryDetails, getProjectsByCategoryId, getCategoriesByProjectId };