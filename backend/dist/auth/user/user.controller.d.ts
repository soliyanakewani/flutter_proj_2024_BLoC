import { UsersService } from './user.service';
import { User } from './schemas/user.schema';
export declare class UserController {
    private readonly userService;
    constructor(userService: UsersService);
    findAllUsers(): Promise<User[]>;
    findOneById(id: string): Promise<User | null>;
    updateUserName(id: string, name: string): Promise<User>;
    updateUserPassword(id: string, password: string): Promise<User>;
    deleteUserById(id: string): Promise<User | null>;
    deleteOwnAccount(id: string, req: any): Promise<User | null>;
}
