import { IsNotEmpty } from "class-validator";

export class UpdateDTO {
    
    id?: string;
    name?: string;
    desc?: string;
    price?: number;
    quantity?: number;

}