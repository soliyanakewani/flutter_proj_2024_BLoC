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
exports.BookingService = void 0;
const common_1 = require("@nestjs/common");
const mongoose_1 = require("@nestjs/mongoose");
const booking_schema_1 = require("./schema/booking.schema");
const mongoose_2 = require("mongoose");
let BookingService = class BookingService {
    constructor(bookModel) {
        this.bookModel = bookModel;
    }
    async findAll() {
        const booked = await this.bookModel.find();
        return booked;
    }
    async findById(id) {
        const isValidId = mongoose_2.default.isValidObjectId(id);
        if (!isValidId) {
            throw new common_1.BadRequestException('please insert a valid id.');
        }
        const room = await this.bookModel.findById(id);
        if (!room) {
            throw new common_1.NotFoundException('Room not found.');
        }
        return room;
    }
    async create(book, userId) {
        const data = Object.assign(book, { user: userId._id });
        const bookedroom = data.roomId;
        if (!bookedroom) {
            throw new common_1.BadRequestException('Room not found');
        }
        const res = await this.bookModel.create(data);
        return res;
    }
    async updateById(id, book, user) {
        try {
            const data = Object.assign(book, { user: user._id });
            const updatedBooking = await this.bookModel.findByIdAndUpdate(id, book, {
                new: true,
                runValidators: true,
            });
            if (!updatedBooking) {
                throw new common_1.NotFoundException(`Booking with ID ${id} not found`);
            }
            return updatedBooking;
        }
        catch (error) {
            console.error('Error updating booking:', error);
            throw new common_1.InternalServerErrorException('Failed to update booking');
        }
    }
    async deleteById(id, user) {
        const data = Object.assign(id, { user: user._id });
        return await this.bookModel.findByIdAndDelete(id);
    }
};
exports.BookingService = BookingService;
exports.BookingService = BookingService = __decorate([
    (0, common_1.Injectable)(),
    __param(0, (0, mongoose_1.InjectModel)(booking_schema_1.Booking.name)),
    __metadata("design:paramtypes", [mongoose_2.default.Model])
], BookingService);
//# sourceMappingURL=booking.service.js.map