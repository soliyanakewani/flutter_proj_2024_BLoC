import { User } from 'src/auth/user/schemas/user.schema';
export declare class CreateBookingDto {
    readonly user: User;
    roomId: string;
    checkInDate: Date;
    checkOutDate: Date;
    numberOfGuests: number;
    bookingDate: Date;
    contactInformation: string;
}
