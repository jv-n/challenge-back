import { IsNotEmpty, Length } from "class-validator";

export class UserDTO {

    id?:string;
    @IsNotEmpty({
        message: "Username can not be empty"
    })
    @Length(1,20, {
        message: "Username must be between 1 and 40 charatcters"
    })
    name: string;
    @IsNotEmpty()
    email: string;
    password: string;
    
}