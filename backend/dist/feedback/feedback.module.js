"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.FeedbackModule = void 0;
const common_1 = require("@nestjs/common");
const mongoose_1 = require("@nestjs/mongoose");
const feedback_controller_1 = require("./feedback.controller");
const feedback_service_1 = require("./feedback.service");
const feedback_schema_1 = require("./schema/feedback.schema");
const passport_1 = require("@nestjs/passport");
let FeedbackModule = class FeedbackModule {
};
exports.FeedbackModule = FeedbackModule;
exports.FeedbackModule = FeedbackModule = __decorate([
    (0, common_1.Module)({
        imports: [
            passport_1.PassportModule.register({ defaultStrategy: 'jwt' }),
            mongoose_1.MongooseModule.forFeature([{ name: feedback_schema_1.Feedback.name, schema: feedback_schema_1.FeedbackSchema }]),
        ],
        controllers: [feedback_controller_1.FeedbackController],
        providers: [feedback_service_1.FeedbackService],
    })
], FeedbackModule);
//# sourceMappingURL=feedback.module.js.map