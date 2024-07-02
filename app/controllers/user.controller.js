import User from '../models/User.js';

export default {
    async createUser(req, res) {
        const {name, email, password} = req.body;
        if (!name || !email || !password) {
            return res.status(400).json({ message: 'Please provide all required fields' });
        };

        try {
            const userExists = await User.findOne({ where: { email } });

            if(existingUser){
                return res.status(400).json({ message: 'Email already registered' });
            }
            const hashedPassword = await bcrypt.hash(password, 10);

            const user = await User.create({ 
                name,
                email,
                password: hashedPassword,
                is_registered: true,
                token: 'your-jwt-token'
            });
    
            return res.status(201).json(user);
            
        } catch (error) {
            return res.status(500).json({ message: 'Internal server error' });         
        }
    },

    async getUsers(req, res) {
        try {
            const users = await User.findAll();
            return res.json(users);
            
        } catch (error) {
            return res.status(500).json({ message: 'Internal server error' });
        };
    },

    async updateUser(req, res) {
        const { id } = req.params;
        const { name, email, password } = req.body;
    
        try {
            const user = await User.findByPk(id);
            
            if (!user) {
                return res.status(404).json({ message: 'User not found' });
            }
            user.name = name;
            user.email = email;
            user.password = password;
    
            await user.save();
    
            return res.json(user);
            
        } catch (error) {
            return res.status(500).json({ message: 'Internal server error' });
        };
    },

    async deleteUser(req, res) {
        const { id } = req.params;

        try {
        const user = await User.findByPk(id);

        if (!user) {
            return res.status(404).json({ message: 'User not found' });
        }

        await user.destroy();

        return res.status(200).json({ message: `${user.name} successfully deleted` });
        } catch (error) {
        return res.status(500).json({ message: 'Internal server error' });
        };
    }
}