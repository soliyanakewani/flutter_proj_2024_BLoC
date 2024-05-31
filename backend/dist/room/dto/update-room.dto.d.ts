import { User } from "src/auth/user/schemas/user.schema";
import { Category } from "../schemas/room.schema";
export declare class UpdateRoomDto {
    readonly title: string;
    readonly description: string;
    readonly price: number;
    readonly category: Category;
    readonly user: User;
    readonly image: string;
}
