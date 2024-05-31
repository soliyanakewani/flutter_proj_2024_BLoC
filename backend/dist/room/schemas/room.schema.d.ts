/// <reference types="mongoose/types/aggregate" />
/// <reference types="mongoose/types/callback" />
/// <reference types="mongoose/types/collection" />
/// <reference types="mongoose/types/connection" />
/// <reference types="mongoose/types/cursor" />
/// <reference types="mongoose/types/document" />
/// <reference types="mongoose/types/error" />
/// <reference types="mongoose/types/expressions" />
/// <reference types="mongoose/types/helpers" />
/// <reference types="mongoose/types/middlewares" />
/// <reference types="mongoose/types/indexes" />
/// <reference types="mongoose/types/models" />
/// <reference types="mongoose/types/mongooseoptions" />
/// <reference types="mongoose/types/pipelinestage" />
/// <reference types="mongoose/types/populate" />
/// <reference types="mongoose/types/query" />
/// <reference types="mongoose/types/schemaoptions" />
/// <reference types="mongoose/types/schematypes" />
/// <reference types="mongoose/types/session" />
/// <reference types="mongoose/types/types" />
/// <reference types="mongoose/types/utility" />
/// <reference types="mongoose/types/validation" />
/// <reference types="mongoose/types/virtuals" />
/// <reference types="mongoose/types/inferschematype" />
import mongoose from "mongoose";
import { User } from "src/auth/user/schemas/user.schema";
export declare enum Category {
    VIP = "VIP",
    MIDDLE = "Middle",
    ECONOMY = "Economy"
}
export declare class Room {
    title: string;
    description: string;
    price: number;
    category: Category;
    user: User;
    image: string;
}
export declare const RoomSchema: mongoose.Schema<Room, mongoose.Model<Room, any, any, any, mongoose.Document<unknown, any, Room> & Room & {
    _id: mongoose.Types.ObjectId;
}, any>, {}, {}, {}, {}, mongoose.DefaultSchemaOptions, Room, mongoose.Document<unknown, {}, mongoose.FlatRecord<Room>> & mongoose.FlatRecord<Room> & {
    _id: mongoose.Types.ObjectId;
}>;
export { User };
