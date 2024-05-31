import { Category, User } from "../schemas/room.schema";
export declare class CreateRoomDto {
    readonly title: string;
    readonly description: string;
    readonly price: number;
    readonly category: Category;
    readonly user: User;
    readonly image: string;
}
