"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};
var __param = (this && this.__param) || function (paramIndex, decorator) {
    return function (target, key) { decorator(target, key, paramIndex); }
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.RoomService = void 0;
const common_1 = require("@nestjs/common");
const mongoose_1 = require("@nestjs/mongoose");
const mongoose = require("mongoose");
const room_schema_1 = require("./schemas/room.schema");
let RoomService = class RoomService {
    constructor(roomModel) {
        this.roomModel = roomModel;
    }
    async findAll() {
        const rooms = await this.roomModel.find().populate('user');
        return rooms;
    }
    async create(roomDto, user) {
        const room = {
            ...roomDto,
            user: user._id
        };
        const createdRoom = await this.roomModel.create(room);
        return createdRoom;
    }
    async findById(id) {
        const isValidId = mongoose.isValidObjectId(id);
        if (!isValidId) {
            throw new common_1.BadRequestException('Please insert a valid ID.');
        }
        const room = await this.roomModel.findById(id).populate('user');
        if (!room) {
            throw new common_1.NotFoundException('Room not found.');
        }
        return room;
    }
    async updateById(id, roomDto, user) {
        const updateData = {
            ...roomDto,
            user: user._id
        };
        const updatedRoom = await this.roomModel.findByIdAndUpdate(id, updateData, {
            new: true,
            runValidators: true
        });
        if (!updatedRoom) {
            throw new common_1.NotFoundException('Room not found.');
        }
        return updatedRoom;
    }
    async deleteById(id, user) {
        const deletedRoom = await this.roomModel.findByIdAndDelete(id);
        if (!deletedRoom) {
            throw new common_1.NotFoundException('Room not found.');
        }
        return deletedRoom;
    }
};
exports.RoomService = RoomService;
exports.RoomService = RoomService = __decorate([
    (0, common_1.Injectable)(),
    __param(0, (0, mongoose_1.InjectModel)(room_schema_1.Room.name)),
    __metadata("design:paramtypes", [mongoose.Model])
], RoomService);
//# sourceMappingURL=room.service.js.map