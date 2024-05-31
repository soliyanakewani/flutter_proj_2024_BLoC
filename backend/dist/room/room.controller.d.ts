import { RoomService } from './room.service';
import { Room } from './schemas/room.schema';
import { CreateRoomDto } from './dto/create-room.dto';
import { UpdateRoomDto } from './dto/update-room.dto';
export declare class RoomController {
    private roomService;
    constructor(roomService: RoomService);
    getAllRooms(): Promise<Room[]>;
    createRoom(room: CreateRoomDto, req: any): Promise<Room>;
    getRoom(id: string): Promise<Room>;
    updateRoom(id: string, room: UpdateRoomDto, req: any): Promise<Room>;
    deleteRoom(id: string, req: any): Promise<Room>;
}
