import { User } from 'src/auth/user/schemas/user.schema';
export declare class UpdateBookingDto {
    readonly user: User;
    readonly roomId: string;
    readonly checkInDate: Date;
    readonly checkOutDate: Date;
    readonly numberOfGuests: number;
    readonly bookingDate: Date;
    readonly contactInformation: string;
}
