import { BookingService } from './booking.service';
import { CreateBookingDto } from './dto/create-booking.dto';
import { Booking } from './schema/booking.schema';
import { UpdateBookingDto } from './dto/update-booking.dto';
export declare class BookingController {
    private bookService;
    constructor(bookService: BookingService);
    getAllBooked(): Promise<Booking[]>;
    getRoom(id: string): Promise<Booking>;
    createBook(book: CreateBookingDto, req: any): Promise<Booking>;
    updateBookingStatus(id: string, book: UpdateBookingDto, req: any): Promise<Booking>;
    deleteRoom(id: string, req: any): Promise<Booking>;
}
