package com.pupilary.provider.dto;

import jakarta.validation.constraints.NotBlank;

import java.io.Serializable;

public class BrandDto implements Serializable {

    @NotBlank
    private String name;

    private String logo;

    private String description;

    private Short status;

}
