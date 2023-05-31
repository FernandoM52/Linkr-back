import joi from "joi";

export const postSchema = joi.object({
  link: joi.string().uri().required(),
  content: joi.string(),
});
