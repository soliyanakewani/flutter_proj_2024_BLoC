import { FeedbackService } from './feedback.service';
import { CreateFeedbackDto } from './dto/create-feedback.dto';
import { UpdateFeedbackDto } from './dto/update-feedback.dto';
export declare class FeedbackController {
    private readonly feedbackService;
    constructor(feedbackService: FeedbackService);
    createFeedback(createFeedbackDto: CreateFeedbackDto, req: any): Promise<import("./schema/feedback.schema").Feedback>;
    getAllFeedback(): Promise<import("./schema/feedback.schema").Feedback[]>;
    updateFeedback(id: string, updateFeedbackDto: UpdateFeedbackDto, req: any): Promise<import("./schema/feedback.schema").Feedback>;
    deleteFeedback(id: string, req: any): Promise<any>;
}
