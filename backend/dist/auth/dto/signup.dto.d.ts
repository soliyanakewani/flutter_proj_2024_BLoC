import { Role } from "../user/schemas/user.schema";
export declare class SignUpDto {
    readonly name: string;
    readonly email: string;
    readonly password: string;
    readonly role: Role;
}
