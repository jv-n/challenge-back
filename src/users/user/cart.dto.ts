import { IsNotEmpty } from "class-validator";

export class CartDTO {
    
    @IsNotEmpty()
    id: string;
    @IsNotEmpty()
    quantity: number;
    @IsNotEmpty()
    email: string

}