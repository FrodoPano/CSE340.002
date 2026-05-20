import { getCategoryDetails, getProjectsByCategoryId } from '../models/categories.js';

const showCategoryDetailsPage = async (req, res) => {
    const categoryId = req.params.id;
    const category = await getCategoryDetails(categoryId);
    const projects = await getProjectsByCategoryId(categoryId);
    const title = category ? category.name : 'Category Not Found';
    
    res.render('category', { title, category, projects });
};

export { showCategoryDetailsPage };